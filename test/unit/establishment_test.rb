require 'test_helper'

class EstablishmentTest < ActiveSupport::TestCase
  context "An Establishment instance" do    
    setup do
      @establishment = Factory.create(:establishment)
    end
    
    should_belong_to :managed_client
    should_belong_to :administrator
    
    should_require_attributes :subject_id, :client_id

    should_have_index [:client_id, :subject_id]
    should_have_index :client_id
    should_have_index :subject_id
  end
end
