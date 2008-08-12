class Role < ActiveRecord::Base
  belongs_to :client

  validates_length_of :name, :within     => 3..30
  
end
