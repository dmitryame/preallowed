def test_generates
  assert_generates("/clients", :controller => "clients", :action => "index")
end

def test_recognizes
  # check the default index action gets generated
  assert_recognizes({"controller" => "home", "action" => "index"}, "/home")
  
  assert_recognizes({"controller" => "clients", "action" => "index"}, "/clients")
  
  # check routing to an action
  assert_recognizes({"controller" => "home", "action" => "index"}, "/home")
  
end