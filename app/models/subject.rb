class Subject < ActiveRecord::Base
  belongs_to              :client
  has_and_belongs_to_many :roles
  has_many                :principals
  has_many                :log_records

  attr_accessor :password, :password_confirmation
  
  # validates_format_of     :email, :with => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i
  # validates_presence_of   :email
  
                                                         
  # validates_presence_of     :password
  #  validates_presence_of     :password_confirmation
  # validates_length_of       :password, :within => 4..40 
  # validates_confirmation_of :password                 
  
protected


  # def update_principals
  #   self.principals.each do |principal|
  #     if principal.principal_type_id == 1
  #       passwordPrincipal = principal
  #     end
  #     if principal.principal_type_id == 2
  #       saltPrincipal = principal
  #     end
  #   end
  #   Subject.encriptPasswords passwordPrincipal, saltPrincipal, self.password
  # end
  
  def self.encriptPasswords(passwordPrincipal, saltPrincipal, passwordValue)
    salt = passwordPrincipal.object_id.to_s + rand.to_s
    string_to_hash = passwordValue + "wibble" + salt
    passwordPrincipal.value = Digest::SHA1.hexdigest(string_to_hash)

    saltPrincipal.value = salt
  end
end
