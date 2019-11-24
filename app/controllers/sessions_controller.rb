class SessionsController < ApplicationController

  def new
  end

  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.find_or_create_from_auth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_back_or user
    else #既存パタン
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        if user.activated?
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          redirect_back_or user
        else
          message  = "アカウントは有効ではありません。 "
          message += "アカウント有効化のメールを確認してください"
          flash[:warning] = message
          redirect_to root_url
        end
      else
        flash.now[:danger] = 'メールアドレス、またはパスワードが不適切です'
        render 'new'
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
