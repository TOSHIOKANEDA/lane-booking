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

ActiveRecord::Schema.define(version: 2019_12_12_132149) do

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "cntr_number"
    t.string "truck"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "t_range"
    t.integer "purpose"
    t.string "booking"
    t.string "ps_card"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "slots", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "date"
    t.integer "am9_10"
    t.integer "am10_11"
    t.integer "am11_12"
    t.integer "pm12_13"
    t.integer "pm13_14"
    t.integer "pm14_15"
    t.integer "pm15_16"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "authority"
    t.string "driver"
    t.string "phone"
    t.string "company"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "orders", "users"
end
