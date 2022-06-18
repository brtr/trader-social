class NftTrade < ApplicationRecord
  belongs_to :user_watchlist
  belongs_to :nft
end
