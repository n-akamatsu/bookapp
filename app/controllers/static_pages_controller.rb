class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @user = User.find_by(id: params[:id])
      @microposts = Micropost.paginate(page: params[:page]).search(params[:title_s], params[:author_s])
      @micropost  = current_user.microposts.build
      @mypost = current_user.myposts.build
    end
  end

  def follow_page
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page]).search(params[:title_s], params[:author_s])
    end
  end

  def about
  end
end
