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

ActiveRecord::Schema[8.0].define(version: 2025_03_06_150028) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "entries", force: :cascade do |t|
    t.string "entry_type"
    t.bigint "space_id", null: false
    t.string "contentful_id"
    t.string "content_type_id"
    t.bigint "published_version"
    t.bigint "revision"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_entries_on_space_id"
  end

  create_table "environments", force: :cascade do |t|
    t.string "contentful_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contentful_id"], name: "index_environments_on_contentful_id", unique: true
  end

  create_table "spaces", force: :cascade do |t|
    t.string "contentful_id"
    t.bigint "environment_id", null: false
    t.datetime "last_synced_at"
    t.string "next_sync_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contentful_id"], name: "index_spaces_on_contentful_id", unique: true
    t.index ["environment_id"], name: "index_spaces_on_environment_id"
  end

  add_foreign_key "entries", "spaces"
  add_foreign_key "spaces", "environments"
end
