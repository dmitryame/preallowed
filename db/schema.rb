# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080812194242) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.boolean  "preallowed", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["name"], :name => "index_clients_on_name"
  add_index "clients", ["preallowed"], :name => "index_clients_on_preallowed"

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.integer  "client_id",  :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resources", ["name"], :name => "index_resources_on_name"
  add_index "resources", ["client_id"], :name => "index_resources_on_client_id"

  create_table "resources_associations", :force => true do |t|
    t.integer  "resource_id", :limit => 11
    t.integer  "role_id",     :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resources_associations", ["resource_id"], :name => "index_resources_associations_on_resource_id"
  add_index "resources_associations", ["role_id"], :name => "index_resources_associations_on_role_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "client_id",  :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"
  add_index "roles", ["client_id"], :name => "index_roles_on_client_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "salt"
    t.integer  "client_id",  :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["client_id"], :name => "index_subjects_on_client_id"
  add_index "subjects", ["client_id", "email"], :name => "index_subjects_on_client_id_and_email"
  add_index "subjects", ["client_id", "name"], :name => "index_subjects_on_client_id_and_name"

  create_table "subjects_associations", :force => true do |t|
    t.integer  "subject_id", :limit => 11
    t.integer  "role_id",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects_associations", ["subject_id"], :name => "index_subjects_associations_on_subject_id"
  add_index "subjects_associations", ["role_id"], :name => "index_subjects_associations_on_role_id"

end
