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

ActiveRecord::Schema.define(:version => 20120707193722) do

  create_table "accounts", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.string   "phone"
    t.string   "fax"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "postcode"
    t.string   "state"
    t.string   "country"
    t.integer  "user_limit"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "accounts", ["name"], :name => "index_accounts_on_name", :unique => true

  create_table "goals", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_date"
    t.date     "due_date"
    t.string   "state"
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "goals", ["review_id"], :name => "index_goals_on_review_id"
  add_index "goals", ["user_id"], :name => "index_goals_on_user_id"

  create_table "periods", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "state"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "periods", ["account_id"], :name => "index_periods_on_account_id"

  create_table "progresses", :force => true do |t|
    t.text     "progress_update"
    t.integer  "percent_complete"
    t.string   "state"
    t.integer  "user_id"
    t.integer  "goal_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "progresses", ["goal_id"], :name => "index_progresses_on_goal_id"
  add_index "progresses", ["user_id"], :name => "index_progresses_on_user_id"

  create_table "reviews", :force => true do |t|
    t.text     "subordinate_comments"
    t.text     "supervisor_comments"
    t.string   "rating"
    t.text     "final_comments"
    t.string   "state"
    t.integer  "user_id"
    t.integer  "period_id"
    t.integer  "account_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "reviews", ["account_id"], :name => "index_reviews_on_account_id"
  add_index "reviews", ["period_id"], :name => "index_reviews_on_period_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username",               :default => "",       :null => false
    t.string   "email",                  :default => "",       :null => false
    t.string   "encrypted_password",     :default => "",       :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role",                   :default => "member"
    t.boolean  "position_supervisor",    :default => false,    :null => false
    t.string   "state"
    t.integer  "account_id"
    t.integer  "supervisor_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "users", ["account_id"], :name => "index_users_on_account_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["supervisor_id"], :name => "index_users_on_supervisor_id"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
