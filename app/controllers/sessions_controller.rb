class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to dashboard_path
    else
      redirect_to login_path
    end
  end

  def create
    # OmniAuth puts all spotify data in this
    auth = request.env["omniauth.auth"]

    user = User.find_or_initialize_by(spotify_id: auth.uid)
    user.update!(
      name: auth.info.name,
      email: auth.info.email,
      access_token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token,
      token_expires_at: Time.at(auth.credentials.expires_at)
    )

    session[:user_id] = user.spotify_id
    redirect_to dashboard_path, notice: "Signed in as #{user.name}"
  end

  def failure
    render plain: "Authentication failed: #{params[:message]}"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end
