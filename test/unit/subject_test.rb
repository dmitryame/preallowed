require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  context "A Subject instance" do    
    setup do
      @subject = Factory(:subject)
    end
    should_belong_to :client
  end    
end
