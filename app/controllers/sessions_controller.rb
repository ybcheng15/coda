class SessionsController < ApplicationController
  def create
    # OmniAuth puts all spotify data in this
    auth = request.env["omniauth.auth"]

    # dump info for now
    render json: {
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      name: auth.info.name,
      image: auth.info.image,
      credentials: {
        token: auth.credentials.token,
        expires_at: Time.at(auth.credentials.expires_at)
      }
    }
  end

  def failure
    render plain: "Authentication failed: #{params[:message]}"
  end
end
