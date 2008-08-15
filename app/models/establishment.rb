class Establishment < ActiveRecord::Base
  belongs_to :managed_client,
  :class_name => "Client", 
  :foreign_key => "client_id"
  
  belongs_to :administrator,
  :class_name => "Subject", 
  :foreign_key => "subject_id"
  
  validates_presence_of :client_id, :subject_id
  
end
