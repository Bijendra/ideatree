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

ActiveRecord::Schema.define(version: 20160524061923) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "assignments", force: :cascade do |t|
    t.text     "description",           limit: 65535
    t.integer  "user_id",               limit: 4
    t.string   "category_id",           limit: 255
    t.boolean  "status",                              default: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "avatar_file_name",      limit: 255
    t.string   "avatar_content_type",   limit: 255
    t.integer  "avatar_file_size",      limit: 4
    t.datetime "avatar_updated_at"
    t.datetime "deleted_at"
    t.string   "title",                 limit: 255
    t.datetime "published_at"
    t.string   "quote",                 limit: 255
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.binary   "data",                  limit: 65535
  end

  add_index "assignments", ["deleted_at"], name: "index_assignments_on_deleted_at", using: :btree

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content",          limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "commentable_id",   limit: 255
    t.string   "commentable_type", limit: 255
    t.string   "user_id",          limit: 255
    t.integer  "assignment_id",    limit: 4
  end

  create_table "likes", force: :cascade do |t|
    t.string   "assignment_id", limit: 255
    t.string   "user_id",       limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "status"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "phone",                  limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "email",                  limit: 255, default: "",   null: false
    t.string   "encrypted_password",     limit: 255, default: "",   null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.datetime "deleted_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.boolean  "notify_me",                          default: true
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visibilities", force: :cascade do |t|
    t.string   "assignment_id", limit: 255
    t.string   "user_id",       limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
