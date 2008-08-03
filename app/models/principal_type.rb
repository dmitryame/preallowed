# TODO: refactor principal/principal type to inheritance model
class PrincipalType < ActiveRecord::Base
  has_many  :principals

  validates_presence_of :name
  validates_uniqueness_of :name

end
