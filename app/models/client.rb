class Client < ActiveRecord::Base
  has_many :subjects  
  has_many :roles
  has_many :resources
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_uniqueness_of :preallowed, :if => :preallowed? #make sure there is only one instance of client preallowed

end
