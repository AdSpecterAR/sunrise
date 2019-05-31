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

ActiveRecord::Schema.define(version: 20190531201838) do

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
    t.boolean "live"
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

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
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

  create_table "posture_courses", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.string "category"
    t.string "difficulty"
    t.text "equipment"
    t.text "description"
    t.string "video_url"
    t.string "gif_url"
    t.string "audio_url"
    t.string "thumbnail_image_url"
    t.bigint "track_id"
    t.integer "order_in_track"
    t.boolean "active"
    t.text "setup_instructions"
    t.integer "completed_count", default: 0
    t.integer "favorited_count", default: 0
    t.integer "view_count", default: 0
    t.datetime "last_completed_at"
    t.datetime "last_favorited_at"
    t.datetime "last_viewed_at"
    t.string "course_type"
    t.index ["track_id"], name: "index_posture_courses_on_track_id"
  end

  create_table "streaks", force: :cascade do |t|
    t.datetime "first_course_date"
    t.datetime "last_course_date"
    t.boolean "active"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_streaks_on_user_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image_url"
    t.string "intro_video_url"
    t.boolean "active"
    t.bigint "user_id"
    t.string "onboarding_text"
    t.string "onboarding_subtext"
    t.string "onboarding_focus_text"
    t.string "key"
    t.index ["user_id"], name: "index_tracks_on_user_id"
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
    t.string "profile_picture_url"
    t.string "firebase_uid"
    t.integer "minutes_exercised"
    t.string "reason"
    t.integer "age"
    t.string "activity_level"
    t.string "gender"
    t.integer "daily_notification_hour"
    t.integer "daily_notification_minute"
    t.integer "courses_completed_count"
    t.string "goals_description"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["firebase_uid"], name: "index_users_on_firebase_uid"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "viewed_posture_courses", force: :cascade do |t|
    t.boolean "completed"
    t.bigint "posture_course_id"
    t.bigint "user_id"
    t.datetime "last_completed_at"
    t.datetime "last_favorited_at"
    t.datetime "last_viewed_at"
    t.integer "completed_count", default: 0
    t.boolean "favorite", default: false
    t.integer "view_count", default: 0
    t.index ["posture_course_id"], name: "index_viewed_posture_courses_on_posture_course_id"
    t.index ["user_id"], name: "index_viewed_posture_courses_on_user_id"
  end

  create_table "viewed_tracks", force: :cascade do |t|
    t.boolean "completed"
    t.bigint "user_id"
    t.bigint "track_id"
    t.boolean "active"
    t.index ["track_id"], name: "index_viewed_tracks_on_track_id"
    t.index ["user_id"], name: "index_viewed_tracks_on_user_id"
  end

  add_foreign_key "course_sessions", "courses"
  add_foreign_key "courses", "users", column: "instructor_id"
  add_foreign_key "plans", "users"
  add_foreign_key "posture_courses", "tracks"
  add_foreign_key "streaks", "users"
  add_foreign_key "tracks", "users"
  add_foreign_key "user_course_sessions", "users", column: "student_id"
  add_foreign_key "viewed_posture_courses", "posture_courses"
  add_foreign_key "viewed_posture_courses", "users"
  add_foreign_key "viewed_tracks", "tracks"
  add_foreign_key "viewed_tracks", "users"
end
