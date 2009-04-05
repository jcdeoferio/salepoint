# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090404124722) do

  create_table "branches", :force => true do |t|
    t.string   "branch_name"
    t.string   "branch_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_branches", :force => true do |t|
    t.integer  "product_id"
    t.integer  "branch_id"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_details", :force => true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "product_name"
    t.integer  "ptype"
    t.integer  "unit_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transaction_details", :force => true do |t|
    t.integer  "transaction_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.date     "date"
    t.integer  "user_id"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "userid"
    t.string   "role"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end