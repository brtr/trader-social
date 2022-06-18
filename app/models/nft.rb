class Nft < ApplicationRecord
  has_many :nft_trades
  has_many :user_nft_tokens
  has_many :nft_comments

  def rate
    nft_comments.average(:rating)
  end
end
