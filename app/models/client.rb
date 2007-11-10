class Client < ActiveRecord::Base
  has_many :scopes 
  has_many :role
  has_many :subjects  
end
