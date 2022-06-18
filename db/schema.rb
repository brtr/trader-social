# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_18_070653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "nft_comments", force: :cascade do |t|
    t.integer "nft_id"
    t.integer "user_id"
    t.integer "rating"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nft_id"], name: "index_nft_comments_on_nft_id"
    t.index ["user_id"], name: "index_nft_comments_on_user_id"
  end

  create_table "nft_trades", force: :cascade do |t|
    t.integer "nft_id"
    t.integer "user_watchlist_id"
    t.integer "block_number"
    t.string "token_id"
    t.string "tx_hash"
    t.string "buyer_address"
    t.string "seller_address"
    t.string "user_address"
    t.string "permalink"
    t.string "image_url"
    t.string "trade_coin"
    t.string "nft_slug"
    t.decimal "price"
    t.decimal "price_usd"
    t.datetime "trade_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_address"], name: "index_nft_trades_on_buyer_address"
    t.index ["nft_id"], name: "index_nft_trades_on_nft_id"
    t.index ["nft_slug"], name: "index_nft_trades_on_nft_slug"
    t.index ["seller_address"], name: "index_nft_trades_on_seller_address"
    t.index ["tx_hash"], name: "index_nft_trades_on_tx_hash"
    t.index ["user_address"], name: "index_nft_trades_on_user_address"
    t.index ["user_watchlist_id"], name: "index_nft_trades_on_user_watchlist_id"
  end

  create_table "nfts", force: :cascade do |t|
    t.string "chain"
    t.string "address"
    t.string "slug"
    t.string "description"
    t.string "opensea_url"
    t.string "logo_url"
    t.integer "total_supply"
    t.decimal "market_cap"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address"], name: "index_nfts_on_address"
    t.index ["chain"], name: "index_nfts_on_chain"
    t.index ["slug"], name: "index_nfts_on_slug"
  end

  create_table "user_nft_tokens", force: :cascade do |t|
    t.integer "nft_id"
    t.integer "user_id"
    t.string "token_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nft_id", "user_id", "token_id"], name: "index_user_nft_tokens_on_nft_id_and_user_id_and_token_id", unique: true
    t.index ["nft_id"], name: "index_user_nft_tokens_on_nft_id"
    t.index ["token_id"], name: "index_user_nft_tokens_on_token_id"
    t.index ["user_id"], name: "index_user_nft_tokens_on_user_id"
  end

  create_table "user_watchlists", force: :cascade do |t|
    t.integer "user_id"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address"], name: "index_user_watchlists_on_address"
    t.index ["user_id"], name: "index_user_watchlists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
