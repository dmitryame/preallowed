class Principal < ActiveRecord::Base
  belongs_to  :subject
  belongs_to  :principal_type
  
  validates_presence_of :value
  
end
