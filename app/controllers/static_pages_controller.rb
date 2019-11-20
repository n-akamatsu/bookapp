class StaticPagesController < ApplicationController

  def home
    @user = User.find_by(id: params[:id])
    @microposts = Micropost.all.paginate(page: params[:page])
  end

  def follow_page
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def about
  end
end
