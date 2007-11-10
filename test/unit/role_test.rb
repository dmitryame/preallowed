require File.dirname(__FILE__) + '/../test_helper'

class RoleTest < Test::Unit::TestCase
  fixtures :roles, :clients

  def test_crud
     preallowed = clients(:preallowed)
     aNewRole = Role.new(
                           :name => "New Test Role",
                           :client => preallowed
                         )
     assert aNewRole.save

     preallowedAdminRole = roles(:preallowed_admin)
     assert_equal "preallowed admin role", preallowedAdminRole.name

     aNewRole.name = "updated name"
     assert aNewRole.save
     aNewRole.reload

     assert_equal "updated name", aNewRole.name

     assert aNewRole.destroy
   end
end
