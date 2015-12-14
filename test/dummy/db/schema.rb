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

ActiveRecord::Schema.define(version: 20151214105231) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.string   "color",                   array: true
    t.integer  "price",                   array: true
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_sources", force: :cascade do |t|
    t.string   "name",             null: false
    t.string   "keys",                          array: true
    t.datetime "cache_timestamp"
    t.integer  "data_entity_id"
    t.string   "data_entity_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "data_sources", ["data_entity_type", "data_entity_id"], name: "index_data_sources_on_data_entity_type_and_data_entity_id", using: :btree
  add_index "data_sources", ["name", "data_entity_id"], name: "index_data_sources_on_name_and_data_entity_id", unique: true, using: :btree
  add_index "data_sources", ["name"], name: "index_data_sources_on_name", using: :btree

end
