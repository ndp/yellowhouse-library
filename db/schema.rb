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

ActiveRecord::Schema.define(version: 20151229053427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_characters", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "book_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "book_characters", ["book_id"], name: "index_book_characters_on_book_id", using: :btree
  add_index "book_characters", ["character_id"], name: "index_book_characters_on_character_id", using: :btree

  create_table "book_subjects", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "book_subjects", ["book_id"], name: "index_book_subjects_on_book_id", using: :btree
  add_index "book_subjects", ["subject_id"], name: "index_book_subjects_on_subject_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "title",      null: false
    t.integer  "author_id"
    t.integer  "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "isbn10"
    t.string   "isbn13"
    t.string   "summary"
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id", using: :btree
  add_index "books", ["genre_id"], name: "index_books_on_genre_id", using: :btree

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "book_characters", "books"
  add_foreign_key "book_characters", "characters"
  add_foreign_key "book_subjects", "books"
  add_foreign_key "book_subjects", "subjects"
  add_foreign_key "books", "authors"
  add_foreign_key "books", "genres"
end
