class Scope < ActiveRecord::Base
  belongs_to  :client
  has_many    :resources  
  has_many    :log_records
end
