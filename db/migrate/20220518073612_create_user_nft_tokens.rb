class CreateUserNftTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :user_nft_tokens do |t|
      t.integer :nft_id
      t.integer :user_id
      t.string  :token_id

      t.timestamps
    end

    add_index :user_nft_tokens, :nft_id
    add_index :user_nft_tokens, :user_id
    add_index :user_nft_tokens, :token_id
    add_index :user_nft_tokens, [:nft_id, :user_id, :token_id], unique: true
  end
end
