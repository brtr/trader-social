class CreateNftComments < ActiveRecord::Migration[6.1]
  def change
    create_table :nft_comments do |t|
      t.integer :nft_id
      t.integer :user_id
      t.integer :rating
      t.text    :body

      t.timestamps
    end

    add_index :nft_comments, :nft_id
    add_index :nft_comments, :user_id
  end
end
