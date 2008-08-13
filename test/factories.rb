Factory.sequence :name do |n|
  "name#{n}" 
end

Factory.sequence :email do |n|
  "person#{n}@example.com" 
end

Factory.sequence :password do |n|
  "Sup3r#{n}" 
end

Factory.define :client do |client|
  client.name {Factory.next :name }
end

Factory.define :subject do |subject|
  subject.name {Factory.next :name }
  subject.email {Factory.next :email }
  subject.password {Factory.next :password }
  subject.salt {Factory.next :password }
  subject.association :client  
end

Factory.define :role do |role|
  role.name {Factory.next :name }
  role.association :client  
end

Factory.define :resource do |resource|
  resource.name {Factory.next :name }
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

