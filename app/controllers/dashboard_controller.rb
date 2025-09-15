class DashboardController < ApplicationController
  before_action :require_login

  def show
    # spotify API calls here
    if @current_user

      client = @current_user.spotify_service
      @profile = client.profile
      @playback_state = client.playback_state(@profile["country"])
      # puts "Playback state: #{@playback_state["item"]["name"]}"

      @top_artists = {
        short_term: client.top_artists(50, "short_term"),
        medium_term: client.top_artists(50, "medium_term"),
        long_term: client.top_artists(50, "long_term")
      }

      @top_tracks = {
        short_term: client.top_tracks(50, "short_term"),
        medium_term: client.top_tracks(50, "medium_term"),
        long_term: client.top_tracks(50, "long_term")
      }
    end
  end

  def require_login
    redirect_to root_path unless logged_in?
  end
end
