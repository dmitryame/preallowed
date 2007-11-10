require File.dirname(__FILE__) + '/../test_helper'

class ResourceTypeTest < Test::Unit::TestCase
  fixtures :resource_types

  def test_crud
    aNewResourceType = ResourceType.new(
                          :name => "New Test resource Type"
                        )
    assert aNewResourceType.save

    resourceTypeFromFixture = resource_types(:url)
    
    assert_equal "URL resource", resourceTypeFromFixture.name
    
    aNewResourceType.name = "updated name"
    assert aNewResourceType.save
    aNewResourceType.reload
    
    assert_equal "updated name", aNewResourceType.name
    
    assert aNewResourceType.destroy

  end
end
