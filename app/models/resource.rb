class Resource < ActiveRecord::Base
  belongs_to :client
  
  has_many :resources_associations
  has_many :roles, :through => :resources_associations, :uniq => true   
  
  
  validates_length_of :name, :within     => 3..2048
  
end
