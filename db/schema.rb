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

ActiveRecord::Schema[8.1].define(version: 2026_08_15_204018) do
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

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "kind", null: false
    t.string "label", null: false
    t.integer "position", default: 0, null: false
    t.boolean "published", default: false, null: false
    t.datetime "updated_at", null: false
    t.string "url", default: "", null: false
    t.index ["kind"], name: "index_contacts_on_kind"
    t.index ["position"], name: "index_contacts_on_position"
  end

  create_table "experiences", force: :cascade do |t|
    t.string "company", default: "", null: false
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.string "period", null: false
    t.integer "position", default: 0, null: false
    t.string "role", null: false
    t.string "technologies", default: [], null: false, array: true
    t.datetime "updated_at", null: false
    t.string "url", default: "", null: false
    t.index ["position"], name: "index_experiences_on_position"
  end

  create_table "profiles", force: :cascade do |t|
    t.text "about", default: "", null: false
    t.text "contact_text", default: "", null: false
    t.string "contact_title", default: "Vamos conversar?", null: false
    t.integer "copyright_year", null: false
    t.datetime "created_at", null: false
    t.string "headline", null: false
    t.string "highlights", default: [], null: false, array: true
    t.text "intro", null: false
    t.string "name", null: false
    t.text "seo_description", default: "", null: false
    t.string "short_name", null: false
    t.string "site_url", default: "", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.boolean "featured", default: false, null: false
    t.string "github", default: "", null: false
    t.string "highlights", default: [], null: false, array: true
    t.string "icon", default: "store", null: false
    t.string "name", null: false
    t.integer "position", default: 0, null: false
    t.string "role", default: "", null: false
    t.string "slug", null: false
    t.text "summary", null: false
    t.string "technologies", default: [], null: false, array: true
    t.datetime "updated_at", null: false
    t.string "url", default: "", null: false
    t.index ["position"], name: "index_projects_on_position"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "icon", default: "", null: false
    t.integer "level", default: 1, null: false
    t.string "name", null: false
    t.integer "position", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["level"], name: "index_skills_on_level"
    t.index ["name"], name: "index_skills_on_name", unique: true
    t.index ["position"], name: "index_skills_on_position"
  end
end
