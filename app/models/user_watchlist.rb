class UserWatchlist < ApplicationRecord
  belongs_to :user
  has_many :nft_trades

  def is_myself?
    address == user.address
  end
end
