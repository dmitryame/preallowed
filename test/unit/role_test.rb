require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  context "A Role instance" do    
    setup do
      @role = Factory(:role)
    end
    subject { @role }
    
    should_belong_to :client
    
    should_have_db_index :name
    should_have_db_index :client_id
    should_have_db_index [:client_id, :name]
    
    
    should_have_many :subjects_associations
    should_have_many :subjects, :through => :subjects_associations

    should_have_many :resources_associations
    should_have_many :resources, :through => :resources_associations
    
    should_ensure_length_in_range :name, (3..30) 

    should_validate_presence_of :name, :client_id

    should_validate_uniqueness_of :name, :scoped_to => :client_id
    
  end    
end
