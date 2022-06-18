class User < ApplicationRecord
  has_many :user_watchlists
  has_many :nft_trades, through: :user_watchlists
  has_many :user_nft_tokens
  has_many :nft_comments
  has_many :nft_rates

  def is_own?(nft_id)
    user_nft_tokens.where(nft_id: nft_id).exists?
  end
end
