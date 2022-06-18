require 'open-uri'

class NftTradesService
  class << self
    def get_latest_trades(watchlist, start_at: nil, end_at: nil, cursor: nil)
      return unless watchlist.address
      start_at ||= (Time.now - 1.week).to_i
      end_at ||= Time.now.to_i
      url = "https://api.opensea.io/api/v1/events?only_opensea=false&event_type=successful&occurred_after=#{start_at}&occurred_before=#{end_at}&account_address=#{watchlist.address}"
      url += "&cursor=#{cursor}" if cursor
      # begin
      response = URI.open(url, {"X-API-KEY" => ENV["OPENSEA_API_KEY"]}).read
      if response
        data = JSON.parse(response)
        data["asset_events"].each do |event|
          asset = event["asset"]
          schema_name = asset["asset_contract"]["schema_name"] rescue ""
          next if asset.nil? || !["ERC721", "METAPLEX"].include?(schema_name)
          token_address = asset["asset_contract"]["address"]
          collection = asset["collection"]
          slug = collection["slug"]
          nft = Nft.where(address: token_address, slug: slug).first_or_create
          nft.update(logo_url: collection["banner_image_url"])
          buyer_address = event["winner_account"]["address"].downcase

          if schema_name == "ERC721"
            payment = event["payment_token"]
            token_id = asset["token_id"]
            price = event["total_price"].to_f / 10 ** payment["decimals"].to_i
            price_usd = price * payment["usd_price"].to_f
            owner_address = asset["owner"]["address"].downcase
            trade_coin = payment["symbol"]
          else
            token_id = asset["name"].split("#").last
            price = event["total_price"].to_f / 10 ** 9
            price_usd = 0
            owner_address = buyer_address
            trade_coin = "SOL"
          end
          tx = event["transaction"]
          trade = nft.nft_trades.where(token_id: token_id, tx_hash: tx["transaction_hash"], user_watchlist_id: watchlist.id).first_or_create
          trade.update(buyer_address: buyer_address, seller_address: event["seller"]["address"].downcase, price: price, price_usd: price_usd,
                      image_url: asset["image_url"], trade_coin: trade_coin, trade_time: DateTime.parse(tx["timestamp"]), nft_slug: slug,
                      block_number: tx["block_number"], permalink: asset["permalink"], user_address: watchlist.address)

          nft.user_nft_tokens.where(user_id: watchlist.user_id, token_id: token_id).first_or_create if owner_address && watchlist.is_myself? && watchlist.address == owner_address
        end

        sleep 1
        get_latest_trades(watchlist, start_at: start_at, end_at: end_at, cursor: data["next"]) if data["next"].present?
      end
      # rescue => e
      #   puts "Fetch opensea Error: #{e}"
      # end
    end
  end
end