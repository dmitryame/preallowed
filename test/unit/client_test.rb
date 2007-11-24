require File.dirname(__FILE__) + '/../test_helper'

class ClientTest < Test::Unit::TestCase
  fixtures :clients

  def test_create
    chaseClient = clients(:chase)
    assert_equal "Chase Manhattan", chaseClient.name
    
    newClient = Client.new(:name  => "Test CLient")
    assert newClient.save
  end
  
  def test_findCLient
    pentagonClient = Client.find_by_name("Pentagon") 
    assert_equal "Pentagon", pentagonClient.name
  end
  
  def test_update
    fleetClient = clients(:fleet)
    assert_equal "Fleet Bank", fleetClient.name
    fleetClient.name="Fleet Bank Updated"
    fleetClient.save
    modifiedFleetClient = Client.find_by_id fleetClient.id
    assert_equal modifiedFleetClient.name, fleetClient.name
  end
  
  def test_delete
    preallowedCLient = clients(:preallowed)
    Client.delete preallowedCLient
    deletedClient = Client.find_by_id preallowedCLient.id
    assert_nil deletedClient
  end
  
  def test_delete_  all
    allClients = Client.find(:all)
    assert_equal allClients.size, 4
    Client.delete_all
    
    allClients = Client.find(:all)
    assert_equal allClients.size, 0
  end
    
end
