class NftsController < ApplicationController
  before_action :get_nft

  def show
    @comments = @nft.nft_comments.order(created_at: :desc).page(params[:page]).per(10)
  end

  def add_comment
    @nft.nft_comments.create(body: params[:comment], user_id: current_user.id, rating: params[:rating])

    redirect_to nft_path(@nft.slug), notice: 'Comment added'
  end

  private
  def get_nft
    @nft = Nft.find_by slug: params[:slug]
  end
end
