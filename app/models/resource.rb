class Resource < ActiveRecord::Base
  belongs_to :client
  
  validates_length_of :name, :within     => 3..2048
  
end
