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

ActiveRecord::Schema.define(version: 20160102121739) do

  create_table "tmessages", force: :cascade do |t|
    t.string   "message"
    t.string   "destination"
    t.datetime "published"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ttweets", force: :cascade do |t|
    t.string   "tweet"
    t.datetime "published"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.string   "latch_id"
    t.integer  "last_tweet",   limit: 8
    t.integer  "last_pm",      limit: 8
    t.integer  "ttweets_id"
    t.integer  "tmessages_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
