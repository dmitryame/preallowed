# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # uncomment to enable https redirection
  # include SslRequirement
  
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_preallowed_session_id'
  before_filter :logrequest
  after_filter :logresponse
  before_filter :authenticate 
  before_filter :authorize
  
  
  # force ssl on the entire application
  def ssl_required?
    true
  end
  
  private
  
  def logrequest
    @log_record             = LogRecord.new
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
  
  #todo: put in a logic to limit number of attempts to 3  
  def authenticate     
    authenticate_or_request_with_http_basic do |name, pass| 
      subject = Subject.find_by_name(name)
      # debugger
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

  # this method (is not an action) is used from different actions and filters as well
  def self.check_helper(subject_id, client, resource_to_verify)
    @subject = client.subjects.find(subject_id)
    
    return true if resource_to_verify == '/home/insufficient'
      

    @subject.roles.each do |role|
      role.resources.each do |resource|
        if resource_to_verify == resource.name # should code a comparison agains ruby regular expressions here
          return true
        end
        return true if resource.name == '/' # hacky hack, really need to replace with reg exp ASAP, for now if resource is '/' give access to the whole application
          
      end
    end
    return false
  end

  # this intercepts all authenticated requests and checks for authorization
  def authorize
    accessible = ApplicationController.check_helper(1, Client.find(1), request.path)
    if accessible == false
      redirect_to :controller => :home, :action => :insufficient
    end

  end

end
