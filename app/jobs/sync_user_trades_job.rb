class SyncUserTradesJob < ApplicationJob
  queue_as :daily_job

  def perform(user_id)
    UserWatchlist.where(user_id: user_id).each do |watchlist|
      SyncSingleWatchlistTradesJob.perform_later(watchlist)
      sleep 1
    end
  end
end