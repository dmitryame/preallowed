# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # uncomment to enable https redirection
  include SslRequirement

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_preallowed_session_id'
  before_filter :logrequest
  after_filter :logresponse
  before_filter :authenticate
  before_filter :authorize 


  # force ssl on the entire application
  def ssl_required?
    if RAILS_ENV == 'production'
      true
    else
      false
    end
  end


  private

  def logrequest
    @log_record             = LogRecord.new
    @log_record.client_id   = params[:client_id]    
    @log_record.req_body    = request.body.string
    @log_record.req_headers = request.headers
    @log_record.req_method  = request.method
    @log_record.req_path    = request.path
    @log_record.save
  end

  def logresponse
    @log_record.resp_headers = response.headers
    @log_record.resp_status  = response.headers["Status"]
    @log_record.save
  end


  # this intercepts all authenticated requests and checks for authorization
  def authorize
    return if skip_authentication 
  
    if check_helper(session[:subject_id], request.path) == false
      redirect_to :controller => :home, :action => :insufficient
    end
  end


  # this method (is not an action) is used from different actions and filters as well
  def check_helper(subject_id, resource_to_verify)    
    return false unless subject_id 

    @subject = Subject.find(subject_id)

    @subject.roles.each do |role|
      role.resources.each do |resource|
        # puts resource_to_verify + '      ~=     ' + resource.name 
        # puts resource_to_verify =~ Regexp.new(resource.name)
        if resource_to_verify =~ Regexp.new(resource.name)
          return true
        end

      end
    end
    return false
  end

  # TODO: put in a logic to limit number of attempts to 3  
  def authenticate         
    return if skip_authentication 
    
    authenticate_or_request_with_http_basic do |name, pass| 
      subject = Subject.find_by_name(name)
      if subject != nil
        stored_hashed_password = ""
        stored_salt = ""
        subject.principals.each do |principal|
          stored_hashed_password = principal.value if principal.principal_type.name == "hashed_password"
          stored_salt = principal.value if principal.principal_type.name == "salt"
        end

        string_to_hash = pass + "wibble" + stored_salt
        hashed_password = Digest::SHA1.hexdigest(string_to_hash)
        if(hashed_password == stored_hashed_password)        
          session[:subject_id] = subject.id #this subject_id is stored in the session to be used in has_access method of a subjects_controller, essentially this is a logged in user id
          session[:subject_name] = subject.name
          return true
        end
      end
    end 
  end 

# defines resources that never require the authentication
  def skip_authentication
    return true if request.path == '/home/insufficient'
    return true if request.path == '/clients/new'  # we need the next two lines as an exception, so that the users can self register new clients.
    return true if request.path == '/clients' and request.method == :post    
  end

end
