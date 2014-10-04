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

ActiveRecord::Schema.define(version: 20141002222911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: true do |t|
    t.integer "user_id"
    t.integer "rant_id"
  end

  create_table "followings", force: true do |t|
    t.integer "follower_id"
    t.integer "followee_id"
  end

  add_index "followings", ["followee_id"], name: "index_followings_on_followee_id", using: :btree
  add_index "followings", ["follower_id", "followee_id"], name: "index_followings_on_follower_id_and_followee_id", unique: true, using: :btree
  add_index "followings", ["follower_id"], name: "index_followings_on_follower_id", using: :btree

  create_table "images", force: true do |t|
    t.integer "user_id"
    t.string  "filename"
    t.string  "content_type"
    t.binary  "data"
  end

  create_table "rants", force: true do |t|
    t.string  "subject"
    t.text    "body"
    t.integer "user_id"
  end

  create_table "users", force: true do |t|
    t.string "username"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.text   "bio"
    t.string "rant_frequency"
  end

end
