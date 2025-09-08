class DashboardController < ApplicationController
  before_action :require_login

  def show
    # spotify API calls here
    if @current_user

      client = @current_user.spotify_service
      @top_artists = client.top_artists(limit: 10, time_range: "short_term")
    end
  end

  def require_login
    redirect_to root_path unless logged_in?
  end
end
