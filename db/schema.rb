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

ActiveRecord::Schema.define(version: 20170205044504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "phone"
    t.string   "country"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "address_1"
    t.string   "address_2"
    t.boolean  "main_address"
    t.float    "longitude"
    t.float    "latitude"
    t.float    "fetched_latitude"
    t.float    "fetched_longitude"
    t.string   "emergency_contact"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["user_id"], name: "index_addresses_on_user_id", using: :btree
  end

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patient_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "services"
    t.string   "las_4_digits"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_patient_profiles_on_user_id", using: :btree
  end

  create_table "patients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "therapists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                    default: "",        null: false
    t.string   "encrypted_password",       default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",          default: 0,         null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "type"
    t.string   "company"
    t.string   "date_of_birth"
    t.boolean  "active",                   default: true,      null: false
    t.float    "longitude"
    t.float    "latitude"
    t.string   "payment_methods",                                           array: true
    t.string   "institution_name"
    t.string   "institution_number"
    t.string   "institution_address"
    t.string   "bank_account_number"
    t.string   "paypal_email"
    t.boolean  "is_superadmin",            default: false
    t.string   "provider"
    t.string   "uid"
    t.boolean  "wizard_completed",         default: false
    t.string   "wizard_step",              default: "welcome"
    t.string   "goverment_issued_id_type"
    t.text     "goverment_issued_id_data"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "patient_profiles", "users"
end
