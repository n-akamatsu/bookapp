class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :following, :followers, :mypage]
  before_action :correct_user,  only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
    @microposts = @user.microposts.paginate(page: params[:page]).search(params[:title_s], params[:author_s])
    @myposts = @user.microposts.paginate(page: params[:page])
    @mypost = current_user.myposts.build if logged_in?
  end

  def mypage
    @user = User.find_by(id: params[:id])
    @myposts = @user.myposts.paginate(page: params[:page]).search(params[:title_s], params[:author_s])
    @mypost = current_user.myposts.build if logged_in?
    @micropost  = current_user.microposts.build if logged_in?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "アカウントを有効化するために届いたメールを確認してください"
      redirect_to @user  #最終的にはroot_urlに変更。エラー回避のため一時的に
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "アップデートしました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "フォロー"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # beforeアクション

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
