class DashboardController < ApplicationController
  before_action :require_user

  def show
    # spotify API calls here
    @user = current_user
  end

  def require_user
    redirect_to root_path unless current_user
  end
end
