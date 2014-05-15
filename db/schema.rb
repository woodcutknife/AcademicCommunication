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

ActiveRecord::Schema.define(version: 20140515025246) do

  create_table "accounts", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true

  create_table "accounts_contest_categories", id: false, force: true do |t|
    t.integer "account_id"
    t.integer "contest_category_id"
  end

  create_table "accounts_roles", id: false, force: true do |t|
    t.integer "account_id"
    t.integer "role_id"
  end

  create_table "contest_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contests", force: true do |t|
    t.string   "name"
    t.integer  "contest_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contests", ["contest_category_id"], name: "index_contests_on_contest_category_id"

  create_table "form_formations", force: true do |t|
    t.integer  "contest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resource"
  end

  add_index "form_formations", ["contest_id"], name: "index_form_formations_on_contest_id"

  create_table "forms", force: true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_id"
    t.integer  "result_id"
  end

  add_index "forms", ["product_id"], name: "index_forms_on_product_id"
  add_index "forms", ["profile_id"], name: "index_forms_on_profile_id"
  add_index "forms", ["result_id"], name: "index_forms_on_result_id"

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "contest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default"
    t.string   "slug"
    t.boolean  "visible"
    t.integer  "z_index"
  end

  add_index "pages", ["contest_id"], name: "index_pages_on_contest_id"

  create_table "product_categories", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "contest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_categories", ["contest_id"], name: "index_product_categories_on_contest_id"

  create_table "products", force: true do |t|
    t.integer  "contest_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_category_id"
  end

  add_index "products", ["account_id"], name: "index_products_on_account_id"
  add_index "products", ["contest_id"], name: "index_products_on_contest_id"
  add_index "products", ["product_category_id"], name: "index_products_on_product_category_id"

  create_table "profiles", force: true do |t|
    t.integer  "account_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["account_id"], name: "index_profiles_on_account_id"
  add_index "profiles", ["product_id"], name: "index_profiles_on_product_id"

  create_table "results", force: true do |t|
    t.integer  "account_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "results", ["account_id"], name: "index_results_on_account_id"
  add_index "results", ["product_id"], name: "index_results_on_product_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "term_formations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "form_formation_id"
    t.string   "type"
    t.string   "name"
    t.boolean  "required"
    t.string   "choises"
    t.boolean  "single"
    t.string   "file_value"
  end

  add_index "term_formations", ["form_formation_id"], name: "index_term_formations_on_form_formation_id"

  create_table "terms", force: true do |t|
    t.integer  "form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "string_value"
    t.integer  "term_formation_id"
    t.text     "text_value"
    t.boolean  "boolean_value"
    t.integer  "integer_value"
  end

  add_index "terms", ["form_id"], name: "index_terms_on_form_id"
  add_index "terms", ["term_formation_id"], name: "index_terms_on_term_formation_id"

end
