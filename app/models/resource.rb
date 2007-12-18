class Resource < ActiveRecord::Base
  belongs_to              :resource_type
  has_and_belongs_to_many :roles
  belongs_to              :scope
  has_many                :log_records

end
