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

ActiveRecord::Schema.define(:version => 20080818121628) do

  create_table "access_logs", :force => true do |t|
    t.integer  "client_id"
    t.string   "request_body",     :limit => 2048
    t.string   "request_headers",  :limit => 2048
    t.string   "request_method"
    t.string   "request_path",     :limit => 2048
    t.string   "response_body",    :limit => 10000
    t.string   "response_headers", :limit => 2048
    t.string   "response_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_logs", ["client_id"], :name => "index_access_logs_on_client_id"

  create_table "clients", :force => true do |t|
    t.string   "name",                          :null => false
    t.boolean  "preallowed", :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["name"], :name => "index_clients_on_name"
  add_index "clients", ["preallowed"], :name => "index_clients_on_preallowed"

  create_table "profiles", :force => true do |t|
    t.integer  "client_id",  :null => false
    t.integer  "subject_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["client_id", "subject_id"], :name => "index_profiles_on_client_id_and_subject_id", :unique => true
  add_index "profiles", ["client_id"], :name => "index_profiles_on_client_id"
  add_index "profiles", ["subject_id"], :name => "index_profiles_on_subject_id"

  create_table "resources", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "client_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resources", ["client_id", "name"], :name => "index_resources_on_client_id_and_name", :unique => true
  add_index "resources", ["name"], :name => "index_resources_on_name"
  add_index "resources", ["client_id"], :name => "index_resources_on_client_id"

  create_table "resources_associations", :force => true do |t|
    t.integer  "resource_id", :null => false
    t.integer  "role_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resources_associations", ["role_id", "resource_id"], :name => "index_resources_associations_on_role_id_and_resource_id", :unique => true
  add_index "resources_associations", ["resource_id"], :name => "index_resources_associations_on_resource_id"
  add_index "resources_associations", ["role_id"], :name => "index_resources_associations_on_role_id"

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "client_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["client_id", "name"], :name => "index_roles_on_client_id_and_name", :unique => true
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
    t.string   "name",            :null => false
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.integer  "client_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["client_id", "name"], :name => "index_subjects_on_client_id_and_name", :unique => true
  add_index "subjects", ["client_id"], :name => "index_subjects_on_client_id"
  add_index "subjects", ["client_id", "email"], :name => "index_subjects_on_client_id_and_email"

  create_table "subjects_associations", :force => true do |t|
    t.integer  "subject_id", :null => false
    t.integer  "role_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects_associations", ["role_id", "subject_id"], :name => "index_subjects_associations_on_role_id_and_subject_id", :unique => true
  add_index "subjects_associations", ["subject_id"], :name => "index_subjects_associations_on_subject_id"
  add_index "subjects_associations", ["role_id"], :name => "index_subjects_associations_on_role_id"

end
