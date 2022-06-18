module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def date_format(datetime)
    datetime.strftime('%Y-%m-%d')
  end

  def get_logo(logo_url)
    logo_url || asset_url("placeholder.png")
  end

  def is_admin?
    admin_ids = ENV.fetch("ADMIN_IDS"){""}.split(',')
    current_user && current_user.id.to_s.in?(admin_ids)
  end

  def address_format(address)
    address[-8..-1]
  end

  def decimal_format(data)
    data.to_f.round(3)
  end

  def home_path
    current_user ? user_trades_path : root_path
  end

  def card_text(trade)
    trade_type = trade.user_address == trade.seller_address ? "Sold" : "Purchased"
    "#{trade_type} ##{trade.token_id} for #{decimal_format trade.price} #{trade.trade_coin} ($#{decimal_format trade.price_usd})"
  end
end
