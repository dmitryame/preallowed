require File.dirname(__FILE__) + '/../test_helper'

class PrincipalTest < Test::Unit::TestCase  
  context "A Principal instance" do    
    setup do
      @password_principal = Factory(:password_principal, :value => "35263a0f3aa0ea37b57027d3c9635725746644e3") # admin
      @salt_principal = Factory(:salt_principal, :value => "291247300.585749468074609") #this salt corresponds to the encripted admin
    end
      
    should_belong_to :subject
    should_belong_to :principal_type
    
    should_require_attributes :value
    
  end
end
