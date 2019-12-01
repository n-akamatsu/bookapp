class MypostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :edit]
  before_action :correct_user,   only: :destroy

  def create
    @mypost = current_user.myposts.build(mypost_params)
    if @mypost.save
      flash[:success] = "「マイ投稿」を作成しました"
      redirect_to mypage_user_path(@current_user)
    else
      flash[:danger] = "投稿に失敗しました"
      redirect_to mypage_user_path(@current_user)
    end
  end

  def destroy
    @mypost.destroy
    flash[:success] = "「マイ投稿」が削除されました"
    redirect_to request.referrer || root_url
    # request.referrer  このメソッドは一つ前のURLを返します
  end

  def edit
  end

  private

    def mypost_params
      params.require(:mypost).permit(:content, :picture, :another_picture, :title, :author)
    end

    def correct_user
      @mypost = current_user.myposts.find_by(id: params[:id])
      redirect_to root_url if @mypost.nil?
    end
end
