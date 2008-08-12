class ResourcesAssociation < ActiveRecord::Base
  belongs_to :resource
  belongs_to :role
end
