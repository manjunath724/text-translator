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

ActiveRecord::Schema.define(version: 2018_09_23_113840) do

  create_table "dictionaries", force: :cascade do |t|
    t.string "word"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "variants", id: false, force: :cascade do |t|
    t.integer "dictionary_a_id", null: false
    t.integer "dictionary_b_id", null: false
    t.index ["dictionary_a_id"], name: "index_variants_on_dictionary_a_id"
    t.index ["dictionary_b_id"], name: "index_variants_on_dictionary_b_id"
  end

end
