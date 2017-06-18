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

ActiveRecord::Schema.define(version: 20160722091908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "attachments", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.integer  "pitch_burn_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "investor_identity_id"
    t.integer  "fund_pitch_burn_id"
  end

  create_table "average_caches", force: :cascade do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "avg",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_ideas", force: :cascade do |t|
    t.integer  "idea_id"
    t.integer  "business_line"
    t.string   "tagline"
    t.text     "problem_statement"
    t.text     "solution"
    t.string   "idea_stage"
    t.string   "ip_patent"
    t.integer  "motivation_vision"
    t.integer  "year_exp"
    t.integer  "startup_business"
    t.integer  "business_model"
    t.text     "des_business_model"
    t.text     "idea_execution"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "business_idea_type"
    t.string   "register_number"
  end

  create_table "business_models", force: :cascade do |t|
    t.integer  "business_potential_id"
    t.integer  "type"
    t.integer  "subtype"
    t.text     "startup_process"
    t.text     "mvp"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "business_potencials", force: :cascade do |t|
    t.integer  "business_idea_id"
    t.integer  "projection_type"
    t.integer  "term_number"
    t.integer  "revenue_type"
    t.string   "per_hour"
    t.string   "recurring"
    t.string   "own_model"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "business_potentials", force: :cascade do |t|
    t.integer  "fund_startup_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "business_teams", force: :cascade do |t|
    t.integer  "team_cappabilitie_id"
    t.string   "name"
    t.string   "role"
    t.string   "skills"
    t.string   "joined"
    t.string   "profile_image"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "idea_id"
    t.text     "message"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitive_protections", force: :cascade do |t|
    t.integer  "business_potential_id"
    t.text     "strategy"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "competitor_teams", force: :cascade do |t|
    t.integer  "competitor_id"
    t.string   "name"
    t.string   "business_line"
    t.string   "country"
    t.string   "revenue"
    t.string   "website"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "competitive_protection_id"
  end

  create_table "competitors", force: :cascade do |t|
    t.integer  "business_idea_id"
    t.string   "image"
    t.text     "about"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "customer_analyses", force: :cascade do |t|
    t.integer  "business_idea_id"
    t.text     "idea_solve"
    t.string   "big_customer"
    t.text     "about"
    t.string   "region",           default: [],              array: true
    t.string   "from_age"
    t.string   "to_age"
    t.text     "steps"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "customer_analyses", ["region"], name: "index_customer_analyses_on_region", using: :gin

  create_table "customer_problems", force: :cascade do |t|
    t.integer  "business_potential_id"
    t.text     "explain"
    t.string   "region"
    t.integer  "from_age"
    t.integer  "to_age"
    t.text     "potential_competitor"
    t.boolean  "checkout"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "deals", force: :cascade do |t|
    t.integer  "idea_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entrepreneurs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.boolean  "gender"
    t.integer  "profession_type"
    t.string   "profession_company"
    t.integer  "profession_skill"
    t.integer  "profession_experience"
    t.string   "graduation"
    t.string   "university"
    t.string   "mobile"
    t.string   "address"
    t.string   "website"
    t.string   "email_second"
    t.text     "about"
    t.text     "inspire_quote"
    t.string   "linkedin"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "skype"
  end

  add_index "entrepreneurs", ["user_id"], name: "index_entrepreneurs_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "entry_type"
    t.integer  "paid_entry_cost_min"
    t.integer  "event_category"
    t.string   "website"
    t.string   "event_image"
    t.string   "partner_logo"
    t.text     "description"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "country"
    t.string   "city"
    t.string   "region"
    t.string   "zipcode"
    t.text     "event_partner"
    t.datetime "event_from"
    t.datetime "event_to"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "timezone"
    t.integer  "views",               default: 0
    t.string   "event_time"
    t.string   "slug"
  end

  create_table "exit_strategies", force: :cascade do |t|
    t.integer  "business_idea_id"
    t.text     "business_exit_strategy"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "idea_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "financials", force: :cascade do |t|
    t.integer  "fund_startup_id"
    t.integer  "revenue"
    t.integer  "often"
    t.integer  "previous_revenue"
    t.integer  "current_revenue"
    t.integer  "previous_netprofit"
    t.boolean  "crowd_funding"
    t.boolean  "put_money"
    t.text     "equity_debt"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.json     "balance_sheets"
    t.json     "cash_flows"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "fund_business_models", force: :cascade do |t|
    t.integer  "business_potential_id"
    t.integer  "type"
    t.integer  "subtype"
    t.text     "startup_process"
    t.text     "mvp"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "fund_market_trends", force: :cascade do |t|
    t.integer  "business_potential_id"
    t.integer  "market_growing"
    t.text     "startup_process"
    t.integer  "market_size"
    t.text     "describe"
    t.string   "approx"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "fund_pitch_burns", force: :cascade do |t|
    t.integer  "fund_startup_id"
    t.string   "pitch"
    t.string   "video"
    t.string   "document"
    t.integer  "prefer_exit"
    t.text     "validation"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "fund_startups", force: :cascade do |t|
    t.integer  "startup_id"
    t.integer  "views"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fundings", force: :cascade do |t|
    t.integer  "funding_type"
    t.integer  "amount"
    t.date     "date"
    t.string   "by_investor"
    t.integer  "startup_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "idea_burns", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.string   "seo_title"
    t.string   "mail_from_address"
    t.string   "default_currency"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "instagram"
    t.string   "tumblr"
    t.string   "twitter"
    t.string   "video"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "ideas", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "title"
    t.text     "description"
    t.string   "attachment"
    t.integer  "views",        default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "idea_type",    default: true
    t.string   "slug"
    t.datetime "purchased_at"
    t.string   "status"
  end

  create_table "investment_scales", force: :cascade do |t|
    t.integer  "business_idea_id"
    t.text     "total_capital"
    t.integer  "fund_already"
    t.integer  "fund_like_to_invest"
    t.text     "fund_you_seeking"
    t.string   "offering_business"
    t.text     "use_fund"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "investor_identities", force: :cascade do |t|
    t.integer  "investor_id"
    t.string   "nationality_identity_proof"
    t.string   "unique_identity_document"
    t.string   "previous_invesment_proofs"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "indentity_proof"
  end

  create_table "investor_teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "designation"
    t.date     "joined_date"
    t.string   "email"
    t.string   "mobile"
    t.string   "linkedin"
    t.string   "skype"
    t.integer  "investor_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
  end

  create_table "investors", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "founded"
    t.integer  "category"
    t.string   "website"
    t.text     "mission"
    t.text     "work"
    t.integer  "register_under"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "description"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "ios_app"
    t.string   "adroid_app"
    t.string   "windows_app"
    t.integer  "business_line",     default: [],              array: true
    t.integer  "investor_type"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "gender"
    t.date     "dob"
    t.string   "website_secondary"
    t.string   "skype"
    t.text     "email_confirm"
    t.string   "confirm_token"
  end

  add_index "investors", ["user_id"], name: "index_investors_on_user_id", using: :btree

  create_table "legal_advisors", force: :cascade do |t|
    t.integer  "fund_startup_id"
    t.boolean  "professional_advisor"
    t.boolean  "board_advisor"
    t.integer  "member"
    t.integer  "professional_advice"
    t.integer  "board_manager"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "like_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "idea_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "market_analyses", force: :cascade do |t|
    t.integer  "business_idea_id"
    t.boolean  "is_new"
    t.boolean  "have_major"
    t.integer  "market_channels"
    t.integer  "market_size"
    t.text     "market_analyses_des"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "market_trend"
  end

  create_table "market_trends", force: :cascade do |t|
    t.integer  "business_potential_id"
    t.integer  "market_growing"
    t.text     "startup_process"
    t.integer  "market_size"
    t.text     "describe"
    t.string   "approx"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "detail"
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "idea_id"
    t.boolean  "seen",        default: false
  end

  create_table "notifications", force: :cascade do |t|
    t.text     "message"
    t.integer  "user_id"
    t.integer  "idea_id"
    t.integer  "notification_type"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "author"
    t.boolean  "seen",              default: false
  end

  create_table "order_transactions", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "idea_id"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.date     "card_expires_on"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "overall_averages", force: :cascade do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "overall_avg",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "own_models", force: :cascade do |t|
    t.integer  "business_potencial_id"
    t.hstore   "revenue",               default: {}, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "partners", force: :cascade do |t|
    t.integer "event_id"
    t.string  "name"
    t.string  "logo"
  end

  create_table "per_hours", force: :cascade do |t|
    t.integer  "business_potencial_id"
    t.hstore   "billable",              default: {}, null: false
    t.hstore   "hour_rate",             default: {}, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "per_units", force: :cascade do |t|
    t.integer  "business_potencial_id"
    t.hstore   "sale",                  default: {}, null: false
    t.hstore   "price",                 default: {}, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "pitch_burns", force: :cascade do |t|
    t.integer  "business_idea_id"
    t.string   "your_own"
    t.string   "your_video"
    t.string   "documents"
    t.text     "your_idea_legally"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "portfolios", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.integer  "fundding_type"
    t.string   "amount"
    t.string   "logo"
    t.integer  "investor_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "product_services", force: :cascade do |t|
    t.text     "about"
    t.integer  "primary_business"
    t.string   "name"
    t.integer  "type"
    t.integer  "subtype"
    t.text     "description"
    t.text     "product_competitive"
    t.integer  "fund_startup_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: :cascade do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "recurrings", force: :cascade do |t|
    t.integer  "business_potencial_id"
    t.hstore   "no_account",            default: {}, null: false
    t.hstore   "charge",                default: {}, null: false
    t.hstore   "churn_rate",            default: {}, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "startups", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "founded"
    t.integer  "category"
    t.string   "website"
    t.string   "strength"
    t.text     "mission"
    t.text     "work"
    t.integer  "register_under"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "reg_company_name"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "ios_app"
    t.string   "adroid_app"
    t.string   "window_app"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.text     "about"
  end

  add_index "startups", ["user_id"], name: "index_startups_on_user_id", using: :btree

  create_table "team_cappabilities", force: :cascade do |t|
    t.integer  "business_idea_id"
    t.integer  "crucial_skills"
    t.integer  "strength"
    t.string   "team_attributes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "designation"
    t.date     "joined_date"
    t.string   "email"
    t.string   "mobile"
    t.string   "linkedin"
    t.string   "skype"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "startup_id"
    t.string   "image"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.integer  "user_type"
    t.string   "country"
    t.string   "city"
    t.string   "region"
    t.string   "photo"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "term"
    t.string   "slug"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "valuations", force: :cascade do |t|
    t.integer  "fund_startup_id"
    t.integer  "currently_outstanding"
    t.integer  "total_fund"
    t.integer  "seeking"
    t.integer  "pre_money"
    t.integer  "business_stake"
    t.text     "use_fund"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

end
