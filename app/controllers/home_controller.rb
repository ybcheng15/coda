class HomeController < ApplicationController
  def index
    @spotify_user = session[:spotify_user]
  end
end
