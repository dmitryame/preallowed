require 'digest/sha1'

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  # uncomment to enable https redirection
  include SslRequirement

  before_filter :authenticate
  before_filter :authorize 


  before_filter :logrequest
  after_filter :logresponse




  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '1f648df8c66dfhkjhakjhdkh90534o5jokj345kjoklec4fa37661768b2d93b'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password


  # force ssl on the entire application TODO: enable ssl in prod when moved to amazon with proper ssl certificate installed
  # def ssl_required?
  #   if RAILS_ENV == 'production'
  #     true
  #   else
  #     false
  #   end
  # end
  
  # this method (is not an action) is used from different actions and filters as well
  # this method is a core of figuring out if a particulalr subject has access to a particular resource.
  # TODO: optimize performance
  def subject_has_access_to_resource?(subject_id, resource_to_verify)    
    return false unless subject_id 
    @subject = Subject.find(subject_id)
    @subject.roles.each do |role|
      role.resources.each do |resource|
        if resource_to_verify =~ Regexp.new(resource.name) #the resource string will be matched agains regular expression -- very powerful
          return true
        end
      end
    end
    return false
  end


  private


  def logrequest
    @access_log                  = AccessLog.new
    @access_log.client_id        = params[:client_id]    
    @access_log.request_body     = request.body.string
    @access_log.request_headers  = request.headers
    @access_log.request_method   = request.method
    @access_log.request_path     = request.path
    @access_log.save
  end

  def logresponse
    @access_log.response_headers = response.headers
    @access_log.response_status  = response.headers["Status"]
    @access_log.response_body    = response.body
    @access_log.save
  end

    # TODO: put in a logic to limit number of attempts to 3  
    def authenticate         
      return if skip_authentication?
      authenticate_or_request_with_http_basic do |name, pass| 
        subject = Subject.authenticate(name, pass)
        if subject != nil
          session[:subject_id] = subject.id #this subject_id is stored in the session to be used in has_access method of a subjects_controller, essentially this is a logged in user id
          session[:subject_name] = subject.name
          true
        end
      end
    end 
    
    # this intercepts all authenticated requests and checks for authorization
    def authorize
      return if skip_authentication?
      return if skip_authorization?
      if subject_has_access_to_resource?(session[:subject_id], request.path) == false
        redirect_to insufficient_path
      end
    end

  # defines resources that never require the authentication
    def skip_authentication?
      return true if request.path == '/home/insufficient'
      return true if request.path == '/home/help'
      return true if request.path == '/'
      return true if request.path == '/profiles/new'  # we need the next two lines as an exception, so that the users can self register new clients.
      return true if request.path == '/profiles' and request.method == :post
      false
    end

    def skip_authorization?
      return true if request.path == '/login'
      return true if request.path == '/clients'
      false
    end

end
