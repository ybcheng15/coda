Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify,
    ENV["SPOTIFY_CLIENT_ID"],
    ENV["SPOTIFY_CLIENT_SECRET"],
    scope: "user-read-email user-read-recently-played user-top-read user-read-playback-state user-read-private "
end
