require 'digest/sha1'

class Subject < ActiveRecord::Base
  belongs_to :client

  has_many :subjects_associations
  has_many :roles, :through => :subjects_associations, :uniq => true   

  validates_presence_of :name, :client_id

  validates_format_of :email, :with      => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i , :if => :email?
  validates_length_of :email, :within    => 3..30, :if => :email?
  validates_length_of :name, :within     => 3..30
  validates_length_of :password, :within => 3..300, :if => :password_present?
  validates_length_of :salt, :within     => 3..100, :if => :password_present?

  validates_uniqueness_of :name, :scope => :client_id
  validates_uniqueness_of :email, :scope => :client_id

  attr_accessor :password_confirmation  
  validates_confirmation_of :password


  def password 
    @password 
  end 
  def password=(pwd) 
    @password = pwd 
    return if pwd.blank? 
    create_new_salt 
    self.hashed_password = Subject.encrypted_password(self.password, self.salt) 
  end 
  def password_present?
    !self.password.blank?
  end

  def self.authenticate(name, password) 
    preallowed_client = Client.find(:first, :conditions => "preallowed = true")
    subject = preallowed_client.subjects.find_by_name(name) 
    if subject
      expected_password = encrypted_password(password, subject.salt) 
      if subject.hashed_password != expected_password 
        subject = nil 
      end 
    end 
    subject
  end 


  private 

  def self.encrypted_password(password, salt) 
    string_to_hash = password + "woobleee" + salt # 'wibble' makes it harder to guess 
    Digest::SHA1.hexdigest(string_to_hash) 
  end 

  def create_new_salt 
    self.salt = self.object_id.to_s + rand.to_s 
  end 
  

end
