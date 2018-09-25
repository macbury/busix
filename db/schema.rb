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

ActiveRecord::Schema.define(version: 17) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "departures", force: :cascade do |t|
    t.integer "time"
    t.integer "day", default: 0
    t.bigint "line_stop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day", "line_stop_id"], name: "index_departures_on_day_and_line_stop_id"
    t.index ["line_stop_id", "day", "time"], name: "index_departures_on_line_stop_id_and_day_and_time"
    t.index ["line_stop_id"], name: "index_departures_on_line_stop_id"
  end

  create_table "directions", force: :cascade do |t|
    t.string "name"
    t.bigint "line_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "target_id"
    t.index ["line_id"], name: "index_directions_on_line_id"
    t.index ["name"], name: "index_directions_on_name"
    t.index ["target_id"], name: "index_directions_on_target_id"
  end

  create_table "line_stops", force: :cascade do |t|
    t.bigint "stop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "direction_id"
    t.index ["stop_id"], name: "index_line_stops_on_stop_id"
  end

  create_table "lines", force: :cascade do |t|
    t.integer "kind", default: 0
    t.integer "name"
    t.bigint "version_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["version_id"], name: "index_lines_on_version_id"
  end

  create_table "stop_locations", force: :cascade do |t|
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.integer "kind"
    t.string "name"
    t.bigint "node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "simple_name"
    t.index ["name"], name: "index_stop_locations_on_name"
    t.index ["node_id"], name: "index_stop_locations_on_node_id"
    t.index ["simple_name"], name: "index_stop_locations_on_simple_name"
  end

  create_table "stops", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "simple_name"
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.integer "version_id"
    t.index ["location"], name: "index_stops_on_location", using: :gist
    t.index ["name"], name: "index_stops_on_name"
    t.index ["simple_name"], name: "index_stops_on_simple_name"
    t.index ["version_id"], name: "index_stops_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "departures", "line_stops"
  add_foreign_key "directions", "lines"
  add_foreign_key "line_stops", "stops"
end
