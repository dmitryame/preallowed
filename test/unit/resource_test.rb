require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  context "A Resource instance" do    
    setup do
      @resource = Factory(:resource)
    end
    should_have_index :name
    should_have_index :client_id
    should_have_index [:client_id, :name]

    should_belong_to :client

    should_have_many :resources_associations
    should_have_many :roles, :through => :resources_associations

    
    should_ensure_length_in_range :name, (3..2048) 

    should_require_attributes :name, :client_id

    should_require_unique_attributes :name, :scoped_to => :client_id
  end    
end
