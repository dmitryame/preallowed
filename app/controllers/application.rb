# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  # uncomment to enable https redirection
  include SslRequirement

  # before_filter :authenticate
  # before_filter :authorize 


  # before_filter :logrequest
  # after_filter :logresponse




  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '1f648df8c66dfhkjhakjhdkh90534o5jokj345kjoklec4fa37661768b2d93b'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password


  # force ssl on the entire application
  def ssl_required?
    if RAILS_ENV == 'production'
      true
    else
      false
    end
  end

  
  
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


  # def logrequest
  #   @log_record             = LogRecord.new
  #   @log_record.client_id   = params[:client_id]    
  #   @log_record.req_body    = request.body.string
  #   @log_record.req_headers = request.headers
  #   @log_record.req_method  = request.method
  #   @log_record.req_path    = request.path
  #   @log_record.save
  # end
  # 
  # def logresponse
  #   @log_record.resp_headers = response.headers
  #   @log_record.resp_status  = response.headers["Status"]
  #   @log_record.save
  # end

    # TODO: put in a logic to limit number of attempts to 3  
    def authenticate         
      return if skip_authentication?

      authenticate_or_request_with_http_basic do |name, pass| 
        preallowed_client = Client.find(:first, :conditions => "preallowed = true")
        subject = preallowed_client.subject.find_by_name(name)
        if subject != nil

          stored_hashed_password = ""
          stored_salt = ""

          string_to_hash = pass + "wibble" + subject.salt
          hashed_password = Digest::SHA1.hexdigest(string_to_hash)
          if(hashed_password == stored_hashed_password)        
            session[:subject_id] = subject.id #this subject_id is stored in the session to be used in has_access method of a subjects_controller, essentially this is a logged in user id
            session[:subject_name] = subject.name
            return true
          end
        end
      end 
    end 
    # this intercepts all authenticated requests and checks for authorization
    def authorize
      return if skip_authentication 

      if subject_has_access_to_resource(session[:subject_id], request.path) == false
        redirect_to :controller => :home, :action => :insufficient
      end
    end

  # defines resources that never require the authentication
    def skip_authentication?
      return true if request.path == '/home/insufficient'
      # return true if request.path == '/clients/new'  # we need the next two lines as an exception, so that the users can self register new clients.
      # return true if request.path == '/clients' and request.method == :post    
      false
    end



end
