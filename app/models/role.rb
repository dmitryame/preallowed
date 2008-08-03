class Role < ActiveRecord::Base
  # TODO: more validation for name
  
  belongs_to              :client
  has_and_belongs_to_many :resources
  has_and_belongs_to_many :subjects
end
