Factory.sequence :name do |n|
  "name#{n}" 
end

Factory.sequence :email do |n|
  "person#{n}@example.com" 
end

Factory.sequence :password do |n|
  "Sup3r#{n}" 
end

Factory.sequence :value do |n|
  "value#{n}" 
end

Factory.define :client do |client|
  client.name { Factory.next :name }
  client.email { Factory.next :email } 
end

Factory.define :subject do |subject|
  subject.name { Factory.next :name }
  subject.email { Factory.next :email }
  subject.password { Factory.next :password }
  subject.password_confirmation { |s| s.password }
  subject.association :client  
end

Factory.define :role do |role|
  role.name { Factory.next :name }
  role.association :client  
end

Factory.define :resource do |resource|
  resource.name { Factory.next :name }
  resource.association :client  
end

Factory.define :subjects_association do |subjects_association|
  subjects_association.association :subject
  subjects_association.association :role
end

Factory.define :resources_association do |resources_association|
  resources_association.association :resource
  resources_association.association :role
end

Factory.define :profile do |profile|
  profile.managed_client { |managed_client| managed_client.association(:client) }
  profile.administrator { |administrator| administrator.association(:subject) }
end

Factory.define :access_log do |acceess_log|
  acceess_log.association :client  
  acceess_log.request_body     { Factory.next :value }
  acceess_log.request_headers  { Factory.next :value }
  acceess_log.request_method   { Factory.next :value }
  acceess_log.request_path     { Factory.next :value }
  acceess_log.response_body    { Factory.next :value }
  acceess_log.response_headers { Factory.next :value }
  acceess_log.response_status  { Factory.next :value }
end
