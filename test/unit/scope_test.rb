require File.dirname(__FILE__) + '/../test_helper'

class ScopeTest < Test::Unit::TestCase

  # def test_crud
  #   preallowed = clients(:preallowed)
  #   aNewTestScope = Scope.new(
  #                         :name => "New Test Scope",
  #                         :client => preallowed
  #                       )
  #   assert aNewTestScope.save
  #   
  #   chaseBankingApplicationScope = scopes(:chase_banking)
  #   assert_equal "Chase banking application scope", chaseBankingApplicationScope.name
  #   
  #   aNewTestScope.name = "updated name"
  #   assert aNewTestScope.save
  #   aNewTestScope.reload
  #   
  #   assert_equal "updated name", aNewTestScope.name
  #   
  #   assert aNewTestScope.destroy
  # end
end
