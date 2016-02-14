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

ActiveRecord::Schema.define(version: 20160214173150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "halts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "longitude",   precision: 10, scale: 7
    t.decimal  "latitude",    precision: 10, scale: 7
    t.string   "description"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "route_halts", force: :cascade do |t|
    t.integer  "route_id"
    t.integer  "halt_id"
    t.integer  "type",       default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "route_halts", ["halt_id"], name: "index_route_halts_on_halt_id", using: :btree
  add_index "route_halts", ["route_id"], name: "index_route_halts_on_route_id", using: :btree

  create_table "routes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.integer  "role_id"
    t.integer  "age"
    t.string   "sex"
    t.string   "address"
    t.string   "work"
    t.integer  "phone"
    t.integer  "vehicle_id"
    t.integer  "route_halt_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree
  add_index "users", ["route_halt_id"], name: "index_users_on_route_halt_id", using: :btree
  add_index "users", ["vehicle_id"], name: "index_users_on_vehicle_id", using: :btree

  create_table "vehicles", force: :cascade do |t|
    t.string   "registration_number"
    t.integer  "capacity"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "route_id"
    t.decimal  "latitude",            precision: 10, scale: 7
    t.decimal  "longitude",           precision: 10, scale: 7
  end

  add_index "vehicles", ["route_id"], name: "index_vehicles_on_route_id", using: :btree

  add_foreign_key "route_halts", "halts"
  add_foreign_key "route_halts", "routes"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "route_halts"
  add_foreign_key "users", "vehicles"
  add_foreign_key "vehicles", "routes"
end
