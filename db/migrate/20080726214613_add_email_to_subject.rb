class AddEmailToSubject < ActiveRecord::Migration
  def self.up
    add_column :subjects, :email, :string
  end

  def self.down
    remove_column :subjects, :email
  end
end
