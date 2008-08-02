# TODO: refactor principal/principal type to inheritance model
class PrincipalType < ActiveRecord::Base
  has_many  :principals
end
