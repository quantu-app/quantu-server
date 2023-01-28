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

ActiveRecord::Schema[7.0].define(version: 2023_01_24_220247) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "learnable_resources", force: :cascade do |t|
    t.bigint "learnable_id"
    t.string "learnable_type"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learnable_type", "learnable_id"], name: "index_learnable_resources_on_learnable_type_and_learnable_id"
    t.index ["user_id"], name: "index_learnable_resources_on_user_id"
  end

  create_table "question_results", force: :cascade do |t|
    t.jsonb "data"
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.bigint "study_session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_results_on_question_id"
    t.index ["study_session_id"], name: "index_question_results_on_study_session_id"
    t.index ["user_id"], name: "index_question_results_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "name", null: false
    t.string "uri", null: false
    t.string "question_type", null: false
    t.integer "item_order"
    t.jsonb "data"
    t.bigint "user_id", null: false
    t.bigint "learnable_resource_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learnable_resource_id"], name: "index_questions_on_learnable_resource_id"
    t.index ["user_id", "uri"], name: "index_questions_on_user_id_and_uri", unique: true
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "name", null: false
    t.string "uri", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "uri"], name: "index_quizzes_on_user_id_and_uri", unique: true
    t.index ["user_id"], name: "index_quizzes_on_user_id"
  end

  create_table "study_sessions", force: :cascade do |t|
    t.jsonb "data"
    t.bigint "user_id", null: false
    t.bigint "learnable_resource_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learnable_resource_id"], name: "index_study_sessions_on_learnable_resource_id"
    t.index ["user_id"], name: "index_study_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "username", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "learnable_resources", "users"
  add_foreign_key "question_results", "questions"
  add_foreign_key "question_results", "study_sessions"
  add_foreign_key "question_results", "users"
  add_foreign_key "questions", "learnable_resources"
  add_foreign_key "questions", "users"
  add_foreign_key "quizzes", "users"
  add_foreign_key "study_sessions", "learnable_resources"
  add_foreign_key "study_sessions", "users"
end
