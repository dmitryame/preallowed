class Client < ActiveRecord::Base
  has_many :scopes 
  has_many :roles
  has_many :subjects  
end
