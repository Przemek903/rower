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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160815102748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bikehistories", force: true do |t|
    t.integer  "stationId"
    t.float    "laf"
    t.float    "lng"
    t.string   "name"
    t.string   "bikes"
    t.integer  "bike_racks"
    t.string   "bike_numbers"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bikes", force: true do |t|
    t.integer  "number"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cluster_agglomeratives", force: true do |t|
    t.float    "lat"
    t.float    "lng"
    t.integer  "numberOfStations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cluster_k_means", force: true do |t|
    t.float    "lat"
    t.float    "lng"
    t.integer  "numberOfStations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cluster_traffics", force: true do |t|
    t.integer  "fromCluster"
    t.integer  "toCluster"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_stations", force: true do |t|
    t.integer  "station_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_tracks", force: true do |t|
    t.integer  "track_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hire_weeks", force: true do |t|
    t.string   "name"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stations", force: true do |t|
    t.integer  "stationNumber"
    t.float    "lng"
    t.float    "lat"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "clusterAgglomerative_id"
    t.integer  "clusterKMean_id"
    t.integer  "hireCount"
  end

  create_table "tracks", force: true do |t|
    t.integer  "fromStation"
    t.integer  "toStation"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "two_direction_traffics", force: true do |t|
    t.integer  "fromFirstToSecond"
    t.integer  "formSecondToFirst"
    t.integer  "totalCount"
    t.integer  "stationA_id"
    t.integer  "stationB_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weathers", force: true do |t|
    t.integer  "max_temp"
    t.integer  "min_temp"
    t.integer  "avg_temp"
    t.string   "conditions"
    t.date     "weather_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count"
  end

end
