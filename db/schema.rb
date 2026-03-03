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

ActiveRecord::Schema[8.1].define(version: 2026_03_03_124736) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.integer "author_id"
    t.string "author_type"
    t.text "body"
    t.datetime "created_at", null: false
    t.string "namespace"
    t.integer "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "airport_bookings", force: :cascade do |t|
    t.text "address"
    t.string "airport"
    t.string "booking_ref"
    t.datetime "created_at", null: false
    t.string "email"
    t.datetime "flight_datetime"
    t.string "flight_number"
    t.string "full_name"
    t.text "notes"
    t.integer "num_passengers"
    t.string "phone"
    t.integer "status"
    t.integer "trip_type"
    t.datetime "updated_at", null: false
    t.string "vehicle_type"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.datetime "created_at"
    t.string "scope"
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "gallery_images", force: :cascade do |t|
    t.string "caption"
    t.string "category"
    t.datetime "created_at", null: false
    t.integer "position"
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.boolean "approved"
    t.string "author_name"
    t.text "body"
    t.datetime "created_at", null: false
    t.integer "rating"
    t.integer "tour_id"
    t.datetime "updated_at", null: false
    t.index ["tour_id"], name: "index_reviews_on_tour_id"
  end

  create_table "tour_bookings", force: :cascade do |t|
    t.string "booking_ref"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "full_name"
    t.integer "num_passengers"
    t.string "phone"
    t.string "pickup_point"
    t.text "special_requests"
    t.integer "status"
    t.integer "total_amount_cents"
    t.integer "tour_id", null: false
    t.date "travel_date"
    t.datetime "updated_at", null: false
    t.index ["tour_id"], name: "index_tour_bookings_on_tour_id"
  end

  create_table "tours", force: :cascade do |t|
    t.boolean "active"
    t.datetime "created_at", null: false
    t.string "departure_time"
    t.text "description"
    t.string "duration"
    t.string "featured_image"
    t.string "featured_image_url"
    t.integer "max_passengers"
    t.string "name"
    t.string "pickup_location"
    t.integer "position"
    t.integer "price_cents"
    t.string "slug"
    t.datetime "updated_at", null: false
  end

  create_table "vehicle_bookings", force: :cascade do |t|
    t.string "booking_ref"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "full_name"
    t.text "notes"
    t.integer "num_passengers"
    t.string "phone"
    t.date "pickup_date"
    t.string "pickup_location"
    t.date "return_date"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.integer "vehicle_id", null: false
    t.index ["vehicle_id"], name: "index_vehicle_bookings_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.boolean "available"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "image"
    t.string "name"
    t.integer "position"
    t.datetime "updated_at", null: false
    t.string "vehicle_type"
  end

  add_foreign_key "reviews", "tours"
  add_foreign_key "tour_bookings", "tours"
  add_foreign_key "vehicle_bookings", "vehicles"
end
