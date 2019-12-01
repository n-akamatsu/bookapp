class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "「みんなの投稿」を作成しました"
      redirect_to root_url
    else
      flash[:danger] = "投稿に失敗しました"
      # @feed_items = []   railsチュートリアルでは一時的にこれにしてる
      @feed_items = current_user.feed.paginate(page: params[:page])
      redirect_to root_url
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "「みんなの投稿」が削除されました"
    redirect_to request.referrer || root_url
    # request.referrer  このメソッドは一つ前のURLを返します
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture, :another_picture, :title, :author)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
