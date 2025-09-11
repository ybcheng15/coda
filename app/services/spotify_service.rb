require "net/http"
require "json"

class SpotifyService
  BASE_URL = "https://api.spotify.com/v1"

  def initialize(token)
    # puts "Initializing SpotifyService with token: #{token}"
    @token = token
  end

  def profile
    get("/me")
  end

  def playback_state(market)
    get("/me/player?market=#{market}")
  end

  def top_artists(limit, time_range)
    get("/me/top/artists?time_range=#{time_range}&limit=#{limit}")
  end

  def top_tracks(limit, time_range)
    get("/me/top/tracks?time_range=#{time_range}&limit=#{limit}")
  end

  private

  def get(path)
    begin
      url = "#{BASE_URL}#{path}"

      response = HTTParty.get(url, {
        headers: {
          "Authorization" => "Bearer #{@token}",
          "Content-Type" => "application/json"
        }
      })

      if response.success?
        Rails.logger.info "Spotify API Request to #{url} successful."

        if response.body.nil? || response.body.empty?
          Rails.logger.info "Spotify API Response body is empty."
          nil
        else
          # Rails.logger.info "Spotify API Response body: #{response.body}"
          JSON.parse(response.body)
        end
      else
        Rails.logger.error "Spotify API Error: #{response.code} - #{response.body}"
        nil
      end


    rescue HTTParty::Error, SocketError => e
      Rails.logger.error "HTTP Error: #{e.message}"
      nil
    end
  end
end
