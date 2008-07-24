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

ActiveRecord::Schema.define(:version => 20080723161723) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_records", :force => true do |t|
    t.string   "req_body",     :limit => 2048
    t.string   "req_headers",  :limit => 2048
    t.string   "req_method",   :limit => 2048
    t.string   "req_path",     :limit => 2048
    t.string   "resp_status",  :limit => 2048
    t.string   "resp_headers", :limit => 2048
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "principal_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "principals", :force => true do |t|
    t.string   "value"
    t.integer  "principal_type_id", :limit => 11, :null => false
    t.integer  "subject_id",        :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "principals", ["subject_id"], :name => "fk_principals_subject"
  add_index "principals", ["principal_type_id"], :name => "fk_principals_principal_type"

  create_table "resource_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.integer  "resource_type_id", :limit => 11, :null => false
    t.integer  "scope_id",         :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resources", ["scope_id"], :name => "fk_resources_scope"
  add_index "resources", ["resource_type_id"], :name => "fk_resources_resource_type"

  create_table "resources_roles", :id => false, :force => true do |t|
    t.integer  "resource_id", :limit => 11, :null => false
    t.integer  "role_id",     :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resources_roles", ["resource_id", "role_id"], :name => "index_resources_roles_on_resource_id_and_role_id"
  add_index "resources_roles", ["role_id"], :name => "index_resources_roles_on_role_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "client_id",  :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["client_id"], :name => "fk_roles_client"

  create_table "roles_subjects", :id => false, :force => true do |t|
    t.integer  "role_id",    :limit => 11, :null => false
    t.integer  "subject_id", :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles_subjects", ["role_id", "subject_id"], :name => "index_roles_subjects_on_role_id_and_subject_id"
  add_index "roles_subjects", ["subject_id"], :name => "index_roles_subjects_on_subject_id"

  create_table "scopes", :force => true do |t|
    t.integer  "client_id",  :limit => 11, :null => false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scopes", ["client_id"], :name => "fk_scopes_client"

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
    t.integer  "client_id",  :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["client_id"], :name => "fk_subjects_client"

end
