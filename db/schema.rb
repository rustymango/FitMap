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

ActiveRecord::Schema[8.1].define(version: 2025_12_21_061037) do
  create_table "businesses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "location"
    t.string "name"
    t.string "services"
    t.datetime "updated_at", null: false
    t.string "website"
  end

  create_table "recent_searches", force: :cascade do |t|
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "last_query_date"
    t.string "service"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_recent_searches_on_user_id"
  end

  create_table "recently_searched_businesses", force: :cascade do |t|
    t.integer "business_id", null: false
    t.datetime "created_at", null: false
    t.integer "recent_search_id", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_recently_searched_businesses_on_business_id"
    t.index ["recent_search_id", "business_id"], name: "idx_recent_search_business_unique", unique: true
    t.index ["recent_search_id"], name: "index_recently_searched_businesses_on_recent_search_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "business_id", null: false
    t.string "comments"
    t.datetime "created_at", null: false
    t.float "score", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["business_id"], name: "index_reviews_on_business_id"
    t.index ["user_id", "business_id"], name: "index_reviews_on_user_id_and_business_id", unique: true
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "saveds", force: :cascade do |t|
    t.integer "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["business_id"], name: "index_saveds_on_business_id"
    t.index ["user_id", "business_id"], name: "index_saveds_on_user_id_and_business_id", unique: true
    t.index ["user_id"], name: "index_saveds_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "recent_searches", "users"
  add_foreign_key "recently_searched_businesses", "businesses"
  add_foreign_key "recently_searched_businesses", "recent_searches"
  add_foreign_key "reviews", "businesses"
  add_foreign_key "reviews", "users"
  add_foreign_key "saveds", "businesses"
  add_foreign_key "saveds", "users"
end
