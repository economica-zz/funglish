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

ActiveRecord::Schema.define(:version => 20121125092604) do

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "occupations", :force => true do |t|
    t.string   "name"
    t.integer  "disp_seq"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "prefectures", :force => true do |t|
    t.string   "name"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "privacy_policies", :force => true do |t|
    t.text     "content"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "privacy_policies", ["deleted"], :name => "idx_privacy_policies_01"

  create_table "sexes", :force => true do |t|
    t.string   "name"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "terms_of_services", :force => true do |t|
    t.text     "content"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "terms_of_services", ["deleted"], :name => "idx_terms_of_services_01"

  create_table "users", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "last_name_kana"
    t.string   "first_name_kana"
    t.integer  "sex_id"
    t.date     "birthday"
    t.integer  "nationality_country_id"
    t.integer  "occupation_id"
    t.integer  "location_country_id"
    t.integer  "location_prefecture_id"
    t.string   "location_city"
    t.string   "email_address"
    t.string   "telephone_number"
    t.string   "skype_name"
    t.string   "google_account"
    t.text     "self_introduction"
    t.string   "facebook_id"
    t.string   "facebook_link"
    t.integer  "terms_of_service_id"
    t.integer  "privacy_policy_id"
    t.boolean  "deleted",                :default => false, :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["email_address", "deleted"], :name => "idx_users_01"
  add_index "users", ["facebook_id", "deleted"], :name => "idx_users_02"

end
