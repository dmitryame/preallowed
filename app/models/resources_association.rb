class ResourcesAssociation < ActiveRecord::Base
  belongs_to :resource
  belongs_to :role
  
  validates_presence_of :resource_id, :role_id
  
end
