class Role < ActiveRecord::Base  
  belongs_to              :client
  has_and_belongs_to_many :resources
  has_and_belongs_to_many :subjects

  validates_presence_of :name

end
