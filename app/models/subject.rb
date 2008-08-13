class Subject < ActiveRecord::Base
  belongs_to :client

  has_many :subjects_associations
  has_many :roles, :through => :subjects_associations, :uniq => true   

  validates_format_of :email, :with      => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i , :if => :email?
  validates_length_of :email, :within    => 3..30, :if => :email?
  validates_length_of :name, :within     => 3..30
  validates_length_of :password, :within => 3..300, :if => :password?

  validates_uniqueness_of :name, :scope => :client_id
  validates_uniqueness_of :email, :scope => :client_id


end
