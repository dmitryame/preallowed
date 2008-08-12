require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  context "A Subject instance" do    
    setup do
      @subject = Factory(:subject)
    end
    should_belong_to :client
    
    should_ensure_length_in_range :email, (3..30) 
    should_ensure_length_in_range :name, (3..30) 
    should_ensure_length_in_range :password, (3..300) 
  end    
end
