class ResourceType < ActiveRecord::Base
  has_many  :resources

  validates_presence_of :name
  validates_uniqueness_of :name

end
