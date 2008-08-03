require File.dirname(__FILE__) + '/../test_helper'

class PrincipalTypeTest < Test::Unit::TestCase
  context "A principal_type instance" do    
    setup do
      @password_principal_type = Factory(:password_principal_type)
      @salt_principal_type = Factory(:salt_principal_type)
    end
  end

  should_have_many :principals

  should_require_attributes :name
  should_require_unique_attributes :name

end
