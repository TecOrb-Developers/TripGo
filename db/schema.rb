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

ActiveRecord::Schema.define(version: 20150423103223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "cities", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "city_name",  default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "cities", ["package_id"], name: "index_cities_on_package_id", using: :btree

  create_table "city_transports", force: :cascade do |t|
    t.integer  "package_id"
    t.integer  "city_id"
    t.string   "city_name"
    t.string   "city_transpotation"
    t.string   "transport_mode"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "city_transports", ["city_id"], name: "index_city_transports_on_city_id", using: :btree
  add_index "city_transports", ["package_id"], name: "index_city_transports_on_package_id", using: :btree

  create_table "comparisions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comparisions", ["package_id"], name: "index_comparisions_on_package_id", using: :btree
  add_index "comparisions", ["user_id"], name: "index_comparisions_on_user_id", using: :btree

  create_table "complaints", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "contact_no"
    t.string   "category"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crms", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "package_id"
    t.string   "name"
    t.string   "destination"
    t.date     "visit_date"
    t.string   "start_from"
    t.string   "assigned_to"
    t.string   "visit_for"
    t.boolean  "is_customize_request"
    t.string   "status"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "crms", ["package_id"], name: "index_crms_on_package_id", using: :btree
  add_index "crms", ["user_id"], name: "index_crms_on_user_id", using: :btree

  create_table "enquiries", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "package_id"
    t.string   "name"
    t.string   "phone_no"
    t.string   "email"
    t.string   "custome_travel"
    t.string   "custome_hotel"
    t.string   "custome_local_transport"
    t.string   "custome_meals"
    t.string   "custome_sights"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "message"
  end

  add_index "enquiries", ["package_id"], name: "index_enquiries_on_package_id", using: :btree
  add_index "enquiries", ["user_id"], name: "index_enquiries_on_user_id", using: :btree

  create_table "hotels", force: :cascade do |t|
    t.integer  "package_id"
    t.integer  "number_of_days"
    t.string   "hotel_name",      default: "", null: false
    t.text     "hotel_address",   default: "", null: false
    t.string   "rating",          default: "", null: false
    t.string   "hotel_amenities", default: [],              array: true
    t.string   "room_type",       default: "", null: false
    t.string   "room_amenities",  default: [],              array: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "city"
  end

  add_index "hotels", ["package_id"], name: "index_hotels_on_package_id", using: :btree

  create_table "inclusions", force: :cascade do |t|
    t.integer  "package_id"
    t.text     "exclusion",           default: "", null: false
    t.text     "conditions",          default: "", null: false
    t.text     "cancallation_policy", default: "", null: false
    t.text     "extra",               default: "", null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "inclusions", ["package_id"], name: "index_inclusions_on_package_id", using: :btree

  create_table "ipaddresses", force: :cascade do |t|
    t.string   "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "itineraries", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "description"
    t.string   "picture"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "itineraries", ["package_id"], name: "index_itineraries_on_package_id", using: :btree

  create_table "meals", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "meal_type"
    t.string   "meal_description", default: ""
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "meals", ["package_id"], name: "index_meals_on_package_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "notifiable_type"
    t.integer  "notifiable_id"
    t.string   "action_type"
    t.integer  "sender"
    t.integer  "reciever"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "is_viewed",       default: false
    t.text     "message",         default: ""
  end

  create_table "offers", force: :cascade do |t|
    t.text     "content"
    t.string   "send_to"
    t.integer  "admin_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "offers", ["admin_user_id"], name: "index_offers_on_admin_user_id", using: :btree

  create_table "packages", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "itinerary_name",     default: "",    null: false
    t.string   "holidays",           default: [],                 array: true
    t.string   "holiday_types",      default: [],                 array: true
    t.float    "price_per_person",   default: 0.0,   null: false
    t.string   "room_sharing",       default: "",    null: false
    t.boolean  "extra_room",         default: false
    t.float    "extra_cost",         default: 0.0,   null: false
    t.string   "package_duration",   default: "",    null: false
    t.boolean  "tag_as_weakend"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "approved",           default: false
    t.string   "included",           default: [],                 array: true
    t.boolean  "recommended_side",   default: false
    t.boolean  "recommended_center", default: false
    t.boolean  "status",             default: false
    t.integer  "inquiry_count",      default: 0
    t.integer  "viewed_count",       default: 0
    t.string   "inventory",          default: ""
  end

  add_index "packages", ["user_id"], name: "index_packages_on_user_id", using: :btree

  create_table "page_contents", force: :cascade do |t|
    t.string   "page"
    t.string   "title"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "image"
    t.string   "imagiable_type"
    t.integer  "imagiable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "agency_name",                     default: "", null: false
    t.string   "based_out_of",                    default: "", null: false
    t.text     "head_office_address",             default: "", null: false
    t.text     "branch_location",                 default: "", null: false
    t.string   "website_name",                    default: "", null: false
    t.text     "travel_association_reference_no", default: "", null: false
    t.text     "about_us",                        default: "", null: false
    t.string   "fb_profile_page",                 default: "", null: false
    t.string   "ln_profile_page",                 default: "", null: false
    t.string   "twitter_profile_page",            default: "", null: false
    t.text     "tour_locations",                  default: ""
    t.text     "category",                        default: [],              array: true
    t.text     "awards",                          default: "", null: false
    t.text     "specilized_in",                   default: [],              array: true
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "logo"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "sight_scenes", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "included"
    t.string   "sight_scene"
    t.string   "guide"
    t.string   "destination"
    t.string   "description"
    t.string   "picture"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sight_scenes", ["package_id"], name: "index_sight_scenes_on_package_id", using: :btree

  create_table "state_cities", force: :cascade do |t|
    t.string   "state"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transports", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "transport_mode"
    t.string   "transport_name"
    t.string   "start"
    t.string   "end"
    t.string   "transfer_section"
    t.string   "transfer_mode"
    t.string   "time_of_onward",   default: [],              array: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "transports", ["package_id"], name: "index_transports_on_package_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "number",                 default: "",    null: false
    t.string   "name",                   default: "",    null: false
    t.string   "contact_no",             default: "",    null: false
    t.string   "role",                   default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "provider_id",            default: "",    null: false
    t.string   "provider",               default: "",    null: false
    t.string   "token",                  default: "",    null: false
    t.datetime "token_expire_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",               default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wishlists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wishlists", ["package_id"], name: "index_wishlists_on_package_id", using: :btree
  add_index "wishlists", ["user_id"], name: "index_wishlists_on_user_id", using: :btree

  add_foreign_key "cities", "packages"
  add_foreign_key "city_transports", "cities"
  add_foreign_key "city_transports", "packages"
  add_foreign_key "comparisions", "packages"
  add_foreign_key "comparisions", "users"
  add_foreign_key "crms", "packages"
  add_foreign_key "crms", "users"
  add_foreign_key "enquiries", "packages"
  add_foreign_key "enquiries", "users"
  add_foreign_key "hotels", "packages"
  add_foreign_key "inclusions", "packages"
  add_foreign_key "itineraries", "packages"
  add_foreign_key "meals", "packages"
  add_foreign_key "offers", "admin_users"
  add_foreign_key "packages", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "sight_scenes", "packages"
  add_foreign_key "transports", "packages"
  add_foreign_key "wishlists", "users"
end
