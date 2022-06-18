class SyncUsersTradesJob < ApplicationJob
  queue_as :default

  def perform
    UserWatchlist.all.each do |watchlist|
      SyncSingleWatchlistTradesJob.perform_later(watchlist)
      sleep 1
    end
  end
end