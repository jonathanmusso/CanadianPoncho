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

ActiveRecord::Schema.define(version: 20151028185616) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "registry_requests", force: :cascade do |t|
    t.datetime "approved_at"
    t.datetime "denied_at"
    t.text     "notes"
    t.integer  "vehicle_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived_at"
  end

  add_index "registry_requests", ["vehicle_id"], name: "index_registry_requests_on_vehicle_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "vehicle_images", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.string   "location"
    t.string   "image"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "primary",    default: false
    t.string   "image_tmp"
  end

  add_index "vehicle_images", ["vehicle_id"], name: "index_vehicle_images_on_vehicle_id"

  create_table "vehicles", force: :cascade do |t|
    t.string   "make"
    t.string   "model"
    t.integer  "year"
    t.string   "production_date"
    t.string   "engine"
    t.string   "transmission"
    t.string   "trim"
    t.string   "color"
    t.string   "options"
    t.string   "location"
    t.text     "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
  end

  add_index "vehicles", ["user_id"], name: "index_vehicles_on_user_id"

end
