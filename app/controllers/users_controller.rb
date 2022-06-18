class UsersController < ApplicationController
  def login
    user = User.where(address: params[:address]).first_or_create
    session[:user_id] = user.id
    SyncUserTradesJob.perform_later(user.id)

    redirect_to user_trades_path, notice: "Sync data successfully, please reload page after 5 minutes"
  end

  def logout
    session[:user_id] = nil if session[:user_id]

    render json: {success: true}
  end

  def trades
    data = NftTrade.joins(:user_watchlist).where(user_watchlists: {user_id: current_user.id}).includes(:nft)
    @q = data.ransack(params[:q])
    @trades = @q.result(distinct: true).order(trade_time: :desc).page(params[:page]).per(50)
  end

  def add_watchlist
    watchlist = current_user.user_watchlists.where(address: params[:address]).first_or_create
    SyncSingleWatchlistTradesJob.perform_later(watchlist)

    redirect_to user_trades_path, notice: "Add address successfully, please wait for sync data"
  end
end
