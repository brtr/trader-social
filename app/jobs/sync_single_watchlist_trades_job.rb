class SyncSingleWatchlistTradesJob < ApplicationJob
  queue_as :daily_job

  def perform(watchlist)
    NftTradesService.get_latest_trades(watchlist)
  end
end