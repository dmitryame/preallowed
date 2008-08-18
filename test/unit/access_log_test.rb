require 'test_helper'

class AccessLogTest < ActiveSupport::TestCase
  context "A access_log instance" do    
    setup do
      @access_log = Factory.create(:access_log)
    end
    
    should_belong_to :client

    should_have_index :client_id
    
  end    
end
