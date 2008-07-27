class Client < ActiveRecord::Base
  has_many :scopes 
  has_many :roles
  has_many :subjects  
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
end
