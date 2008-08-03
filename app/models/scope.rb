class Scope < ActiveRecord::Base
  belongs_to  :client
  has_many    :resources  

  validates_presence_of :name

end
