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

ActiveRecord::Schema.define(version: 20160920044248) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "revenue",          limit: 4,                  default: 0
    t.decimal  "menu_cost",                    precision: 10, default: 0
    t.decimal  "profit",                       precision: 10, default: 0
    t.integer  "cash",             limit: 4,                  default: 0
    t.integer  "cash_loss",        limit: 4,                  default: 0
    t.integer  "saving_point",     limit: 4,                  default: 0
    t.integer  "pre_money",        limit: 4,                  default: 0
    t.integer  "end_money",        limit: 4,                  default: 0
    t.integer  "cash_buy",         limit: 4,                  default: 0
    t.date     "account_date"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "use_point",        limit: 4
    t.string   "cash_buy_content", limit: 255
  end

  create_table "comments", force: :cascade do |t|
    t.string   "cs_content",   limit: 255
    t.boolean  "read_confirm",             default: false
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "comments", ["user_id"], name: "fk_rails_03de2dc08c", using: :btree

  create_table "costs", force: :cascade do |t|
    t.integer  "material_id", limit: 4
    t.integer  "employee_id", limit: 4
    t.string   "buy_content", limit: 255
    t.integer  "buy_price",   limit: 4
    t.date     "buy_date"
    t.boolean  "buy_pament",              default: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "costs", ["employee_id"], name: "index_costs_on_employee_id", using: :btree
  add_index "costs", ["material_id"], name: "fk_rails_51407c110f", using: :btree

  create_table "details", force: :cascade do |t|
    t.integer  "menu_id",    limit: 4
    t.integer  "order_id",   limit: 4
    t.integer  "order_unit", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "details", ["menu_id"], name: "index_details_on_menu_id", using: :btree
  add_index "details", ["order_id"], name: "index_details_on_order_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "student_number",  limit: 255
    t.string   "employee_name",   limit: 255
    t.string   "employee_phone",  limit: 255
    t.string   "employee_email",  limit: 255
    t.date     "employee_birth"
    t.integer  "cardinal_number", limit: 4
    t.string   "employee_image",  limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "image_url",       limit: 255
  end

  create_table "materials", force: :cascade do |t|
    t.string   "material_name",     limit: 255
    t.string   "material_buyer",    limit: 255
    t.string   "material_url",      limit: 255
    t.decimal  "material_volume",               precision: 10
    t.integer  "material_unit",     limit: 4
    t.decimal  "material_limit",                precision: 6,  scale: 2
    t.integer  "material_price",    limit: 4
    t.integer  "material_shipping", limit: 4
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.string   "scale",             limit: 255
    t.boolean  "display",                                                default: true
    t.integer  "material_order",    limit: 4,                            default: 999
    t.integer  "employee_id",       limit: 4
  end

  add_index "materials", ["employee_id"], name: "index_materials_on_employee_id", using: :btree

  create_table "menu_categories", force: :cascade do |t|
    t.string   "category_code",  limit: 255
    t.string   "category_title", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "menus", force: :cascade do |t|
    t.string   "menu_title",       limit: 255
    t.string   "menu_symbol",      limit: 255
    t.string   "menu_degree",      limit: 255
    t.integer  "menu_price",       limit: 4
    t.integer  "menu_category_id", limit: 4
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
    t.decimal  "unit_price",                   precision: 6, scale: 2, default: 0.0
    t.boolean  "display",                                              default: true
    t.integer  "menu_order",       limit: 4,                           default: 999
    t.integer  "menu_size",        limit: 4,                           default: 1
    t.boolean  "menu_promo",                                           default: false
  end

  create_table "offcomments", force: :cascade do |t|
    t.string   "user_name",    limit: 255
    t.string   "user_number",  limit: 255
    t.string   "user_content", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "order_number",  limit: 255
    t.integer  "use_point",     limit: 4
    t.boolean  "make_confirm",              default: false
    t.boolean  "order_confirm",             default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "orders_users", force: :cascade do |t|
    t.integer  "order_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "orders_users", ["order_id"], name: "index_orders_users_on_order_id", using: :btree
  add_index "orders_users", ["user_id"], name: "index_orders_users_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.date     "buy_date"
    t.integer  "category",    limit: 4
    t.string   "buy_content", limit: 255
    t.integer  "price",       limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.integer  "material_id",   limit: 4
    t.integer  "menu_id",       limit: 4
    t.decimal  "material_unit",           precision: 10
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "recipes", ["material_id"], name: "index_recipes_on_material_id", using: :btree
  add_index "recipes", ["menu_id"], name: "index_recipes_on_menu_id", using: :btree

  create_table "sales", force: :cascade do |t|
    t.integer  "menu_id",    limit: 4
    t.integer  "menu_sales", limit: 4, default: 0
    t.date     "date_sales"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "sales", ["menu_id"], name: "index_sales_on_menu_id", using: :btree

  create_table "semesters", force: :cascade do |t|
    t.string   "year",       limit: 255
    t.string   "semester",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "storages", force: :cascade do |t|
    t.date     "storage_date"
    t.decimal  "storage_unit",           precision: 6, scale: 2
    t.integer  "material_id",  limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "storages", ["material_id"], name: "index_storages_on_material_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "team",        limit: 255
    t.string   "job",         limit: 255
    t.integer  "employee_id", limit: 4
    t.integer  "semester_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "teams", ["employee_id"], name: "index_teams_on_employee_id", using: :btree
  add_index "teams", ["semester_id"], name: "index_teams_on_semester_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "user_email",  limit: 255
    t.string   "user_name",   limit: 255
    t.string   "password",    limit: 255
    t.string   "user_number", limit: 255
    t.string   "user_major",  limit: 255
    t.string   "user_job",    limit: 255
    t.integer  "user_money",  limit: 4,   default: 0
    t.boolean  "admin",                   default: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "user_rate",   limit: 4,   default: 0
  end

  add_foreign_key "comments", "users"
  add_foreign_key "costs", "employees"
  add_foreign_key "costs", "materials"
  add_foreign_key "details", "menus"
  add_foreign_key "details", "orders"
  add_foreign_key "recipes", "materials"
  add_foreign_key "recipes", "menus"
  add_foreign_key "sales", "menus"
  add_foreign_key "storages", "materials"
  add_foreign_key "teams", "employees"
  add_foreign_key "teams", "semesters"
end
