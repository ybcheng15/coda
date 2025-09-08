class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :logged_in?

  private


  def logged_in?
    @current_user ||= User.find_by(spotify_id: session[:user_id])
    @current_user.present?
  end
end
