require "sidekiq/pro/web"
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  root "home#index"

  post 'login', to: "users#login", as: :login
  post 'logout', to: "users#logout", as: :logout
  get '/trades', to: "users#trades", as: :user_trades
  post '/users/add_watchlist', to: "users#add_watchlist", as: :add_watchlist

  get '/nfts/:slug', to: "nfts#show", as: :nft
  post '/nfts/:slug/add_comment', to: "nfts#add_comment", as: :add_comment
end
