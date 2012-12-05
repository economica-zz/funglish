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

ActiveRecord::Schema.define(:version => 20121205074328) do

  create_table "auth_statuses", :force => true do |t|
    t.string   "name"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "lesson_id"
    t.integer  "user_id"
    t.text     "content"
    t.boolean  "is_parent",         :default => false, :null => false
    t.integer  "parent_comment_id"
    t.boolean  "deleted",           :default => false, :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "comments", ["lesson_id", "deleted"], :name => "idx_comments_01"
  add_index "comments", ["parent_comment_id", "deleted"], :name => "idx_comments_02"

  create_table "conversation_forms", :force => true do |t|
    t.string   "name"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "youtube_src"
    t.string   "cloudinary_public_id"
    t.boolean  "deleted",              :default => false, :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "guest_statuses", :force => true do |t|
    t.string   "name"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "guests", :force => true do |t|
    t.integer  "schedule_id"
    t.integer  "user_id"
    t.integer  "guest_status_id"
    t.boolean  "deleted",         :default => false, :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "guests", ["schedule_id", "user_id", "deleted", "guest_status_id"], :name => "idx_guests_01"
  add_index "guests", ["user_id", "schedule_id", "deleted", "guest_status_id"], :name => "idx_guests_02"

  create_table "lesson_materials", :force => true do |t|
    t.integer  "lesson_id"
    t.integer  "material_id"
    t.string   "file_name"
    t.boolean  "deleted",     :default => false, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "lesson_materials", ["lesson_id", "deleted"], :name => "idx_lesson_materials_01"

  create_table "lessons", :force => true do |t|
    t.integer  "course_id"
    t.integer  "number"
    t.string   "name"
    t.integer  "price"
    t.string   "cloudinary_public_id"
    t.text     "description"
    t.boolean  "is_released"
    t.date     "scheduled_release_date"
    t.date     "release_date"
    t.string   "panda_video_id"
    t.boolean  "is_main_lesson",         :default => false, :null => false
    t.integer  "main_lesson_id"
    t.boolean  "deleted",                :default => false, :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "lessons", ["course_id", "is_main_lesson", "deleted"], :name => "idx_lessons_01"
  add_index "lessons", ["main_lesson_id", "is_main_lesson", "deleted"], :name => "idx_lessons_02"

  create_table "materials", :force => true do |t|
    t.string   "name"
    t.string   "icon_file_name"
    t.text     "description"
    t.boolean  "deleted",        :default => false, :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "occupations", :force => true do |t|
    t.string   "name"
    t.integer  "disp_seq"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "payment_methods", :force => true do |t|
    t.string   "name"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "payments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.integer  "payment_method_id"
    t.integer  "amount"
    t.datetime "pay_timestamp"
    t.datetime "expiration_timestamp"
    t.boolean  "deleted",              :default => false, :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "payments", ["lesson_id", "user_id", "deleted"], :name => "idx_payments_02"
  add_index "payments", ["user_id", "lesson_id", "deleted"], :name => "idx_payments_01"

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

  create_table "schedule_comments", :force => true do |t|
    t.integer  "schedule_id"
    t.integer  "user_id"
    t.text     "content"
    t.boolean  "deleted",     :default => false, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "schedule_comments", ["schedule_id", "deleted"], :name => "idx_schedule_comments_01"

  create_table "schedules", :force => true do |t|
    t.integer  "user_id"
    t.datetime "start_timestamp"
    t.datetime "end_timestamp"
    t.integer  "time"
    t.integer  "lesson_id"
    t.integer  "conversation_form_id"
    t.integer  "location_prefecture_id"
    t.string   "location_name"
    t.string   "location_reference_url"
    t.integer  "maximum_number_of_guests"
    t.text     "message"
    t.boolean  "deleted",                  :default => false, :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "schedules", ["lesson_id", "start_timestamp", "deleted"], :name => "idx_schedules_01"
  add_index "schedules", ["user_id", "end_timestamp", "deleted"], :name => "idx_schedules_02"

  create_table "sexes", :force => true do |t|
    t.string   "name"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "teachers", :force => true do |t|
    t.integer  "course_id"
    t.string   "name"
    t.string   "cloudinary_public_id"
    t.text     "description"
    t.boolean  "deleted",              :default => false, :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "teachers", ["course_id", "deleted"], :name => "idx_teachers_01"

  create_table "terms_of_services", :force => true do |t|
    t.text     "content"
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "terms_of_services", ["deleted"], :name => "idx_terms_of_services_01"

  create_table "time_zones", :force => true do |t|
    t.string   "name",                          :null => false
    t.boolean  "dst",                           :null => false
    t.string   "utc_offset",                    :null => false
    t.integer  "disp_seq",                      :null => false
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

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
    t.integer  "time_zone_id"
    t.string   "email_address"
    t.string   "telephone_number"
    t.string   "skype_name"
    t.string   "google_account"
    t.text     "self_introduction"
    t.string   "facebook_id"
    t.string   "facebook_link"
    t.integer  "terms_of_service_id"
    t.integer  "privacy_policy_id"
    t.boolean  "is_email_address_confirmed",      :default => false, :null => false
    t.string   "email_address_confirmation_code"
    t.boolean  "deleted",                         :default => false, :null => false
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  add_index "users", ["email_address", "deleted"], :name => "idx_users_01"
  add_index "users", ["facebook_id", "deleted"], :name => "idx_users_02"

  create_table "views", :force => true do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.integer  "auth_status_id"
    t.boolean  "deleted",        :default => false, :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "views", ["lesson_id", "user_id", "auth_status_id"], :name => "idx_views_02"
  add_index "views", ["user_id", "lesson_id", "auth_status_id"], :name => "idx_views_01"

end
