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

ActiveRecord::Schema.define(:version => 20121206043858) do

  create_table "bars", :force => true do |t|
    t.string   "name",                                                                                        :null => false
    t.integer  "num_of_screens"
    t.integer  "fan_intensity_rating"
    t.integer  "team_id"
    t.datetime "created_at",                                                                                  :null => false
    t.datetime "updated_at",                                                                                  :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "image_link",           :default => "https://www.filepicker.io/api/file/XtYfCwzlSiqpJNiMpjKP"
    t.string   "address",                                                                                     :null => false
    t.string   "city",                                                                                        :null => false
    t.string   "state",                                                                                       :null => false
    t.string   "zip_code",                                                                                    :null => false
    t.string   "neighborhood"
    t.integer  "user_id"
  end

  create_table "bars_games", :force => true do |t|
    t.integer  "bar_id"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bars_games", ["bar_id", "game_id"], :name => "index_bars_games_on_bar_id_and_game_id", :unique => true

  create_table "games", :force => true do |t|
    t.datetime "game_at",      :null => false
    t.integer  "home_team_id", :null => false
    t.integer  "away_team_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "games", ["away_team_id"], :name => "index_games_on_away_team_id"
  add_index "games", ["home_team_id"], :name => "index_games_on_home_team_id"

  create_table "teams", :force => true do |t|
    t.string   "team_name"
    t.string   "home_city"
    t.string   "logo_path"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "marker_img_path"
    t.string   "small_logo_path"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "name",                                      :null => false
    t.string   "provider"
    t.string   "uid"
    t.boolean  "bar_owner",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
