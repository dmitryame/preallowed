require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  context "An Profile instance" do    
    setup do
      @profile = Factory.create(:profile)
    end
    
    should_belong_to :managed_client
    should_belong_to :administrator
    
    should_require_attributes :subject_id, :client_id

    should_have_index [:client_id, :subject_id]
    should_have_index :client_id
    should_have_index :subject_id
  end
end
