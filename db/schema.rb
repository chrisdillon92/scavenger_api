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

ActiveRecord::Schema.define(version: 20160908184421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hunt_templates", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "duration_min"
    t.integer  "objectives_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["objectives_id"], name: "index_hunt_templates_on_objectives_id", using: :btree
  end

  create_table "hunts", force: :cascade do |t|
    t.integer  "hunt_template_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "player_id"
    t.index ["hunt_template_id"], name: "index_hunts_on_hunt_template_id", using: :btree
    t.index ["player_id"], name: "index_hunts_on_player_id", using: :btree
  end

  create_table "objectives", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "answer"
    t.boolean  "completed",        default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "hunt_template_id"
    t.index ["hunt_template_id"], name: "index_objectives_on_hunt_template_id", using: :btree
  end

  create_table "player_objectives", force: :cascade do |t|
    t.boolean  "completed"
    t.integer  "hunt_id"
    t.integer  "objective_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["hunt_id"], name: "index_player_objectives_on_hunt_id", using: :btree
    t.index ["objective_id"], name: "index_player_objectives_on_objective_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "hunt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hunt_id"], name: "index_players_on_hunt_id", using: :btree
  end

  add_foreign_key "hunt_templates", "objectives", column: "objectives_id"
  add_foreign_key "hunts", "hunt_templates"
  add_foreign_key "hunts", "players"
  add_foreign_key "player_objectives", "hunts"
  add_foreign_key "player_objectives", "objectives"
  add_foreign_key "players", "hunts"
end
