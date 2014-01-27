# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140124225705) do

  create_table "citations", :force => true do |t|
    t.string   "message"
    t.integer  "user_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "range_end"
    t.integer  "range_begin"
    t.integer  "note_id",     :default => 1, :null => false
  end

  create_table "notes", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "week_id"
    t.text     "body"
    t.boolean  "deadline",   :default => false, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.text     "description"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "encrypted_password", :default => "", :null => false
    t.integer  "sign_in_count",      :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "full_name"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "weeks", :force => true do |t|
    t.datetime "publishing_date"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
