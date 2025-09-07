class DashboardController < ApplicationController
  before_action :require_login

  def show
    @spotify_user = session[:spotify_user]
    # spotify API calls here
    if @spotify_user

      client = SpotifyService.new(session[:spotify_user]["token"])
      @top_artists = client.top_artists(limit: 10, time_range: "short_term")
    end
  end

  def require_login
    redirect_to root_path unless logged_in?
  end
end
