class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @like = Like.new(user_id: @current_user.id, post_id: params[:micropost_id])
    @like.save
    redirect_to root_url
  end

  def destroy
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:micropost_id])
    @like.destroy
    redirect_to root_url
  end
end
