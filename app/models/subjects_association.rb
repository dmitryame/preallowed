class SubjectsAssociation < ActiveRecord::Base
  belongs_to :subject
  belongs_to :role
  
  validates_presence_of :subject_id, :role_id
  
end
