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

ActiveRecord::Schema.define(version: 20180806045757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_sessions", force: :cascade do |t|
    t.datetime "start_time"
    t.integer "duration"
    t.string "video_url"
    t.string "thumbnail_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_id"
    t.index ["course_id"], name: "index_course_sessions_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.string "category"
    t.string "difficulty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "instructor_id"
    t.text "description"
    t.string "equipment"
    t.index ["instructor_id"], name: "index_courses_on_instructor_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "stripe_plan_id"
    t.string "interval"
    t.boolean "available"
    t.boolean "active"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "user_course_sessions", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "course_session_id"
    t.string "rating"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_session_id"], name: "index_user_course_sessions_on_course_session_id"
    t.index ["student_id"], name: "index_user_course_sessions_on_student_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "authentication_token", limit: 30
    t.boolean "admin"
    t.boolean "instructor"
    t.string "fb_authentication_token"
    t.string "fb_user_id"
    t.boolean "fb_account"
    t.string "stripe_customer_id"
    t.string "stripe_subscription_id"
    t.string "avatar_url"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "course_sessions", "courses"
  add_foreign_key "courses", "users", column: "instructor_id"
  add_foreign_key "plans", "users"
  add_foreign_key "user_course_sessions", "users", column: "student_id"
end
