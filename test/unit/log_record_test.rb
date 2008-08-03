require File.dirname(__FILE__) + '/../test_helper'

class LogRecordTest < Test::Unit::TestCase
  context "A log_record instance" do    
    setup do
      @log_record = Factory(:log_record)
    end
  end

end
