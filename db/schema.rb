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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120823141051) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "efforts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "food_items", :force => true do |t|
    t.string   "name"
    t.decimal  "price"
    t.boolean  "certified",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "ingredients", :force => true do |t|
    t.integer  "food_item_id"
    t.string   "quantity"
    t.string   "measure"
    t.integer  "recipe_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "recipes", :force => true do |t|
    t.integer  "many_ppl"
    t.string   "title"
    t.integer  "effort_id",     :limit => 255
    t.integer  "time"
    t.integer  "category_id"
    t.string   "text"
    t.boolean  "approved"
    t.binary   "extra_content"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

end
