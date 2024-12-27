# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_12_23_131524) do
  create_table "contact_details", force: :cascade do |t|
    t.string "email"
    t.string "mobile_number"
    t.integer "resident_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resident_id"], name: "index_contact_details_on_resident_id"
  end

  create_table "emergency_contacts", force: :cascade do |t|
    t.string "name"
    t.string "relationship"
    t.string "mobile_number"
    t.string "email"
    t.integer "resident_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resident_id"], name: "index_emergency_contacts_on_resident_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "unitary_amount"
    t.string "method"
    t.string "transaction_id"
    t.date "transaction_date"
    t.string "reason"
    t.integer "resident_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resident_id"], name: "index_payments_on_resident_id"
  end

  create_table "proof_of_ids", force: :cascade do |t|
    t.string "identifier_type"
    t.string "identifier_value"
    t.integer "resident_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resident_id"], name: "index_proof_of_ids_on_resident_id"
  end

  create_table "residents", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stay_details", force: :cascade do |t|
    t.date "move_in_date"
    t.string "duration_of_stay"
    t.text "special_requirements"
    t.integer "resident_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resident_id"], name: "index_stay_details_on_resident_id"
  end

  add_foreign_key "contact_details", "residents"
  add_foreign_key "emergency_contacts", "residents"
  add_foreign_key "payments", "residents"
  add_foreign_key "proof_of_ids", "residents"
  add_foreign_key "stay_details", "residents"
end
