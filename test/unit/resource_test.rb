require File.dirname(__FILE__) + '/../test_helper'

class ResourceTest < Test::Unit::TestCase

  # def test_crud
  #   resourceType = resource_types(:url)
  #   scopePreallowedAdminInterface = scopes(:preallowed_admin_interface)
  #   resourceGranted = Resource.new(
  #                            :name    => 'testing resource granted',
  #                            :resource_type => resourceType,
  #                            :scope => scopePreallowedAdminInterface
  #                            )
  # 
  #   assert resourceGranted.save
  # 
  #   resourceDenied = Resource.new(
  #                            :name    => 'testing resource denied',
  #                            :resource_type => resourceType,
  #                            :scope => scopePreallowedAdminInterface
  #                            )
  # 
  #   assert resourceDenied.save
  # 
  #   resourceDenied.name = 'testing updating the name'
  # 
  #   assert resourceDenied.save
  # 
  #   assert resourceDenied.reload
  # 
  #   assert resourceDenied.destroy
  #   assert resourceGranted.destroy
  # end
end
