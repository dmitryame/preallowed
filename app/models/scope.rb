class Scope < ActiveRecord::Base
  belongs_to  :client
  has_many    :resources  
end
