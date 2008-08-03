class Resource < ActiveRecord::Base
  # TODO: more validations for name
  
    
  belongs_to              :resource_type
  has_and_belongs_to_many :roles
  belongs_to              :scope
end
