class User < ApplicationRecord
  def spotify_service
    refresh_access_token_if_expired!
    SpotifyService.new(access_token)
  end

  private

  def refresh_access_token_if_expired!
    return if token_expires_at && token_expires_at.future?

    auth_response = RestClient.post("https://accounts.spotify.com/api/token", {
      grant_type: "refresh_token",
      refresh_token: refresh_token,
      client_id: ENV["SPOTIFY_CLIENT_ID"],
      client_secret: ENV["SPOTIFY_CLIENT_SECRET"]
    })

    data = JSON.parse(auth_response.body)

    puts "*********New access token: #{data["access_token"]}*********"
    update!(
      access_token: data["access_token"],
      token_expires_at: Time.now + data["expires_in"].seconds
    )
  end
end
