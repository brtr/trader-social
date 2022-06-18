class CreateUserWatchlists < ActiveRecord::Migration[6.1]
  def change
    create_table :user_watchlists do |t|
      t.integer :user_id
      t.string  :address

      t.timestamps
    end

    add_index :user_watchlists, :user_id
    add_index :user_watchlists, :address
  end
end
