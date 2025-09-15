class DashboardController < ApplicationController
  before_action :require_login

  def show
    # spotify API calls here
    if @current_user

      client = @current_user.spotify_service
      @profile = client.profile
      @playback_state = client.playback_state(@profile["country"])
      # puts "Playback state: #{@playback_state["item"]["name"]}"
      @top_artists = client.top_artists(20, "short_term")
      @top_tracks = client.top_tracks(20, "short_term")
    end
  end

  def require_login
    redirect_to root_path unless logged_in?
  end
end
