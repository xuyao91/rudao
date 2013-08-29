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

ActiveRecord::Schema.define(:version => 20130829083121) do

  create_table "admins", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.integer  "manage_type"
    t.datetime "deleted_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "auths", :force => true do |t|
    t.string   "code",       :null => false
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "banks", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.string   "name",          :null => false
    t.boolean  "sex",           :null => false
    t.string   "identity_card", :null => false
    t.string   "bank_card",     :null => false
    t.integer  "bank_kind",     :null => false
    t.string   "bank_address",  :null => false
    t.datetime "deleted_at"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "brands", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.integer  "brand_id",   :null => false
    t.integer  "pattern_id", :null => false
    t.string   "title",      :null => false
    t.text     "content",    :null => false
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "patterns", :force => true do |t|
    t.integer  "brand_id",   :null => false
    t.integer  "name",       :null => false
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "point_logs", :force => true do |t|
    t.integer  "user_id",                                   :null => false
    t.integer  "product_id",                                :null => false
    t.integer  "point",                                     :null => false
    t.decimal  "price",      :precision => 10, :scale => 0, :null => false
    t.integer  "kind",                                      :null => false
    t.datetime "deleted_at"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "products", :force => true do |t|
    t.integer  "brand_id",   :null => false
    t.integer  "pattern_id", :null => false
    t.string   "code",       :null => false
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_shops", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "shop_id",    :null => false
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
