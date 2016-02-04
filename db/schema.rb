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

ActiveRecord::Schema.define(version: 20140426174201) do

  create_table "buses", force: true do |t|
    t.integer  "bus_capacity"
    t.string   "bus_driver"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "route_id"
    t.string   "bus_no"
  end

  create_table "halts", force: true do |t|
    t.string   "halt_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bus_id"
    t.time     "bus_arrivetime"
    t.time     "bus_departtime"
    t.integer  "route_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "title"
    t.text     "description"
  end

  create_table "positions", force: true do |t|
    t.string   "route"
    t.string   "current_pos"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "alert"
  end

  create_table "routes", force: true do |t|
    t.string   "route_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
    t.string   "destination"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "s_lat"
    t.float    "s_long"
    t.text     "alert"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.text     "address"
    t.string   "job_type"
    t.integer  "bus_id"
    t.integer  "route_id"
    t.integer  "halt_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
