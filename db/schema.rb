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

ActiveRecord::Schema[7.0].define(version: 2023_07_30_032204) do
  create_table "courses", id: false, force: :cascade do |t|
    t.integer "course_id", null: false
    t.string "short_description"
    t.string "catalog_number"
    t.string "course_description"
    t.string "course_name"
    t.string "academic_career"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_courses_on_course_id", unique: true
  end

  create_table "grader_applications", force: :cascade do |t|
    t.string "first_name"
    t.string "email"
    t.integer "course_id"
    t.integer "section_id"
    t.string "days_of_the_week_available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "grade_received"
    t.string "status"
    t.time "time_start_available"
    t.time "time_end_available"
    t.string "last_name"
  end

  create_table "recommendations", force: :cascade do |t|
    t.string "instructor_email"
    t.integer "course_id"
    t.integer "section_id"
    t.string "student_email"
    t.string "testimonial"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", id: false, force: :cascade do |t|
    t.integer "section_id", null: false
    t.string "section_number"
    t.integer "course_id"
    t.string "catalog_number"
    t.string "term_id"
    t.string "campus"
    t.string "days_of_week"
    t.time "time_start"
    t.time "time_end"
    t.string "location"
    t.string "instructor_name"
    t.string "instructor_email"
    t.integer "current_num_required_graders"
    t.integer "num_required_graders"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_sections_on_section_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.boolean "user_approved", default: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
