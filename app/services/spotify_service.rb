require "net/http"
require "json"

class SpotifyService
  BASE_URL = "https://api.spotify.com/v1"

  def initialize(token)
    # puts "Initializing SpotifyService with token: #{token}"
    @token = token
  end

  def top_artists(limit: 10, time_range: "medium_term")
    get("/me/top/artists?time_range=#{time_range}&limit=#{limit}")
  end

  def top_tracks(limit: 10)
    get("me/top/tracks?limit=#{limit}")
  end

  private

  def get(path)
    uri = URI("#{BASE_URL}#{path}")
    req = Net::HTTP::Get.new(uri)
    req["Authorization"] = "Bearer #{@token}"


    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end

    JSON.parse(res.body)
  end

  def make_request(url)
    response = HTTParty.get(url, headers: { "Authorization" => "Bearer #{@token}" })

    response.success? ? JSON.parse(response.body) : { "error" => response.message }
  end
end
