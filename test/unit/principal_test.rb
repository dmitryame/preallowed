require File.dirname(__FILE__) + '/../test_helper'

class PrincipalTest < Test::Unit::TestCase
  fixtures :principals, :principal_types, :subjects
  

  def test_crud
    principalType = principal_types(:password)
    principalPreallowedAdminPassowrd = principals(:preallowed_admin_password)
    testPasswordPrincipal = Principal.new(
                             :value    => 'testing principal',
                             :principal_type => principalType,
                             :subject => subjects(:super_user)
                             )

    assert testPasswordPrincipal.save

    testCertificatePrincipal = Principal.new(
                             :value    => 'testing certificate principal',
                             :principal_type => principal_types(:password),
                             :subject => subjects(:super_user)
                             )

    assert testCertificatePrincipal.save

    testCertificatePrincipal.value = 'testing updating the name'

    assert testCertificatePrincipal.save

    assert testCertificatePrincipal.reload
  
    assert testCertificatePrincipal.destroy
    assert testPasswordPrincipal.destroy
  end

end
