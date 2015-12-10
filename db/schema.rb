# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151210130444) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contents", force: :cascade do |t|
    t.integer  "set_cube_id"
    t.text     "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contents", ["set_cube_id"], name: "index_contents_on_set_cube_id", using: :btree

  create_table "cubes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "tit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "set_cubes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shared_contents", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "content_id"
    t.integer  "set_cube_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "shared_contents", ["content_id"], name: "index_shared_contents_on_content_id", using: :btree
  add_index "shared_contents", ["set_cube_id"], name: "index_shared_contents_on_set_cube_id", using: :btree
  add_index "shared_contents", ["user_id"], name: "index_shared_contents_on_user_id", using: :btree

  create_table "shared_cubes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "set_cube_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "is_shared",   default: false
  end

  add_index "shared_cubes", ["set_cube_id"], name: "index_shared_cubes_on_set_cube_id", using: :btree
  add_index "shared_cubes", ["user_id"], name: "index_shared_cubes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
