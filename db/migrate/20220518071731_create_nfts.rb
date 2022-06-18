class CreateNfts < ActiveRecord::Migration[6.1]
  def change
    create_table :nfts do |t|
      t.string  :chain
      t.string  :address
      t.string  :slug
      t.string  :description
      t.string  :opensea_url
      t.string  :logo_url
      t.integer :total_supply
      t.decimal :market_cap

      t.timestamps
    end

    add_index :nfts, :chain
    add_index :nfts, :address
    add_index :nfts, :slug
  end
end
