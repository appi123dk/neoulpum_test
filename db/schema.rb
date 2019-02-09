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

ActiveRecord::Schema.define(version: 20190209104354) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "revenue",          default: 0
    t.decimal  "menu_cost",        default: 0.0
    t.decimal  "profit",           default: 0.0
    t.integer  "cash",             default: 0
    t.integer  "cash_loss",        default: 0
    t.integer  "saving_point",     default: 0
    t.integer  "pre_money",        default: 0
    t.integer  "end_money",        default: 0
    t.integer  "cash_buy",         default: 0
    t.date     "account_date"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "use_point"
    t.string   "cash_buy_content"
    t.string   "employee_name"
    t.integer  "kakao_money",      default: 0
  end

  create_table "comments", force: :cascade do |t|
    t.string   "cs_content"
    t.boolean  "read_confirm", default: false
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "costs", force: :cascade do |t|
    t.integer  "material_id"
    t.integer  "employee_id"
    t.string   "buy_content"
    t.integer  "buy_price"
    t.date     "buy_date"
    t.boolean  "buy_pament",  default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "costs", ["employee_id"], name: "index_costs_on_employee_id"

  create_table "coupons", force: :cascade do |t|
    t.string   "c_name"
    t.string   "content"
    t.integer  "unit"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "details", force: :cascade do |t|
    t.integer  "menu_id"
    t.integer  "order_id"
    t.integer  "order_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "details", ["menu_id"], name: "index_details_on_menu_id"
  add_index "details", ["order_id"], name: "index_details_on_order_id"

  create_table "employees", force: :cascade do |t|
    t.string   "student_number"
    t.string   "employee_name"
    t.string   "employee_phone"
    t.string   "employee_email"
    t.date     "employee_birth"
    t.integer  "cardinal_number"
    t.string   "employee_image"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "image_url"
  end

  create_table "materials", force: :cascade do |t|
    t.string   "material_name"
    t.string   "material_buyer"
    t.string   "material_url"
    t.decimal  "material_volume"
    t.integer  "material_unit"
    t.decimal  "material_limit",    precision: 6, scale: 2
    t.integer  "material_price"
    t.integer  "material_shipping"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "scale"
    t.boolean  "display",                                   default: true
    t.integer  "material_order",                            default: 999
    t.integer  "employee_id"
    t.boolean  "is_order",                                  default: false
    t.date     "order_date"
  end

  add_index "materials", ["employee_id"], name: "index_materials_on_employee_id"

  create_table "menu_categories", force: :cascade do |t|
    t.string   "category_code"
    t.string   "category_title"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "menus", force: :cascade do |t|
    t.string   "menu_title"
    t.string   "menu_symbol"
    t.string   "menu_degree"
    t.integer  "menu_price"
    t.integer  "menu_category_id"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.decimal  "unit_price",       precision: 6, scale: 2, default: 0.0
    t.boolean  "display",                                  default: true
    t.integer  "menu_order",                               default: 999
    t.integer  "menu_size",                                default: 1
    t.boolean  "menu_promo",                               default: false
  end

  create_table "mycoupons", force: :cascade do |t|
    t.integer  "coupon_id"
    t.integer  "user_id"
    t.integer  "unit",       default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "mycoupons", ["coupon_id"], name: "index_mycoupons_on_coupon_id"
  add_index "mycoupons", ["user_id"], name: "index_mycoupons_on_user_id"

  create_table "offcomments", force: :cascade do |t|
    t.string   "user_name"
    t.string   "user_number"
    t.string   "user_content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "order_number"
    t.integer  "use_point"
    t.boolean  "make_confirm",  default: false
    t.boolean  "order_confirm", default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "is_kakao",      default: false
  end

  create_table "orders_users", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orders_users", ["order_id"], name: "index_orders_users_on_order_id"
  add_index "orders_users", ["user_id"], name: "index_orders_users_on_user_id"

  create_table "payments", force: :cascade do |t|
    t.date     "buy_date"
    t.integer  "category"
    t.string   "buy_content"
    t.integer  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.integer  "material_id"
    t.integer  "menu_id"
    t.decimal  "material_unit", precision: 6, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "recipes", ["material_id"], name: "index_recipes_on_material_id"
  add_index "recipes", ["menu_id"], name: "index_recipes_on_menu_id"

  create_table "sales", force: :cascade do |t|
    t.integer  "menu_id"
    t.integer  "menu_sales", default: 0
    t.date     "date_sales"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sales", ["menu_id"], name: "index_sales_on_menu_id"

  create_table "semesters", force: :cascade do |t|
    t.string   "year"
    t.string   "semester"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "storages", force: :cascade do |t|
    t.date     "storage_date"
    t.decimal  "storage_unit", precision: 6, scale: 2
    t.integer  "material_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "storages", ["material_id"], name: "index_storages_on_material_id"

  create_table "teams", force: :cascade do |t|
    t.string   "team"
    t.string   "job"
    t.integer  "employee_id"
    t.integer  "semester_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "teams", ["employee_id"], name: "index_teams_on_employee_id"
  add_index "teams", ["semester_id"], name: "index_teams_on_semester_id"

  create_table "users", force: :cascade do |t|
    t.string   "user_email"
    t.string   "user_name"
    t.string   "password"
    t.string   "user_number"
    t.string   "user_major"
    t.string   "user_job"
    t.integer  "user_money",  default: 0
    t.boolean  "admin",       default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_rate",   default: 0
    t.string   "birthday"
    t.boolean  "resting",     default: false
    t.integer  "count",       default: 0
    t.boolean  "is_group",    default: false
  end

end
