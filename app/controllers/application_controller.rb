class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  private

  def current_user
    # @current_user ||= User.find_by(id: session[:user_id])
    # call api
  end

  def logged_in?
    # bug
    # puts "session[:spotify_user]: #{session[:spotify_user].inspect}"
    session[:spotify_user].present?
  end
end
