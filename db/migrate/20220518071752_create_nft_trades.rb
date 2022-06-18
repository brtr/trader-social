class CreateNftTrades < ActiveRecord::Migration[6.1]
  def change
    create_table :nft_trades do |t|
      t.integer  :nft_id
      t.integer  :user_watchlist_id
      t.integer  :block_number
      t.string   :token_id
      t.string   :tx_hash
      t.string   :buyer_address
      t.string   :seller_address
      t.string   :user_address
      t.string   :permalink
      t.string   :image_url
      t.string   :trade_coin
      t.string   :nft_slug
      t.decimal  :price
      t.decimal  :price_usd
      t.datetime :trade_time

      t.timestamps
    end

    add_index :nft_trades, :nft_id
    add_index :nft_trades, :user_watchlist_id
    add_index :nft_trades, :tx_hash
    add_index :nft_trades, :buyer_address
    add_index :nft_trades, :seller_address
    add_index :nft_trades, :user_address
    add_index :nft_trades, :nft_slug
  end
end
