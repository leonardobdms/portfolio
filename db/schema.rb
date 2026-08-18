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

ActiveRecord::Schema[8.1].define(version: 2026_08_18_190008) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "certifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "credential_id"
    t.string "credential_url"
    t.text "description"
    t.date "expires_at"
    t.date "issued_at"
    t.string "issuer", null: false
    t.string "name", null: false
    t.integer "position", default: 0, null: false
    t.bigint "profile_id", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id", "position"], name: "index_certifications_on_profile_id_and_position"
  end

  create_table "educations", force: :cascade do |t|
    t.string "course", null: false
    t.datetime "created_at", null: false
    t.boolean "current", default: false, null: false
    t.string "degree"
    t.text "description"
    t.date "end_date"
    t.string "institution", null: false
    t.integer "position", default: 0, null: false
    t.bigint "profile_id", null: false
    t.date "start_date", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id", "position"], name: "index_educations_on_profile_id_and_position"
  end

  create_table "experiences", force: :cascade do |t|
    t.string "company", null: false
    t.datetime "created_at", null: false
    t.boolean "current", default: false, null: false
    t.text "description"
    t.string "employment_type"
    t.date "end_date"
    t.string "location"
    t.integer "position", default: 0, null: false
    t.bigint "profile_id", null: false
    t.string "role", null: false
    t.date "start_date", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id", "position"], name: "index_experiences_on_profile_id_and_position"
  end

  create_table "profiles", force: :cascade do |t|
    t.boolean "available_for_work", default: false, null: false
    t.string "avatar_url"
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "github_url"
    t.string "headline"
    t.string "linkedin_url"
    t.string "location"
    t.string "name", null: false
    t.string "phone"
    t.string "resume_url"
    t.datetime "updated_at", null: false
    t.string "website_url"
  end

  create_table "project_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "project_id", null: false
    t.bigint "skill_id", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "skill_id"], name: "index_project_skills_on_project_id_and_skill_id", unique: true
    t.index ["skill_id"], name: "index_project_skills_on_skill_id"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "demo_url"
    t.text "description"
    t.date "end_date"
    t.boolean "featured", default: false, null: false
    t.string "github_url"
    t.string "image_url"
    t.string "name", null: false
    t.integer "position", default: 0, null: false
    t.bigint "profile_id", null: false
    t.string "short_description"
    t.string "slug", null: false
    t.date "start_date"
    t.datetime "updated_at", null: false
    t.index ["featured"], name: "index_projects_on_featured"
    t.index ["profile_id", "position"], name: "index_projects_on_profile_id_and_position"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "skills", force: :cascade do |t|
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "icon", null: false
    t.string "level"
    t.string "name", null: false
    t.integer "position", default: 0, null: false
    t.bigint "profile_id", null: false
    t.string "slug", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_skills_on_category"
    t.index ["profile_id", "position"], name: "index_skills_on_profile_id_and_position"
    t.index ["slug"], name: "index_skills_on_slug", unique: true
  end

  create_table "social_links", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "icon"
    t.string "platform", null: false
    t.integer "position", default: 0, null: false
    t.bigint "profile_id", null: false
    t.datetime "updated_at", null: false
    t.string "url", null: false
    t.string "username"
    t.index ["platform"], name: "index_social_links_on_platform"
    t.index ["profile_id", "position"], name: "index_social_links_on_profile_id_and_position"
  end

  add_foreign_key "certifications", "profiles"
  add_foreign_key "educations", "profiles"
  add_foreign_key "experiences", "profiles"
  add_foreign_key "project_skills", "projects"
  add_foreign_key "project_skills", "skills"
  add_foreign_key "projects", "profiles"
  add_foreign_key "skills", "profiles"
  add_foreign_key "social_links", "profiles"
end
