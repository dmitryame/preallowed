# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '1f648df8c66dfhkjhakjhdkh90534o5jokj345kjoklec4fa37661768b2d93b'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  
  
  
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

end
