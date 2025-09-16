class UserTopCache < ApplicationRecord
  belongs_to :user

  validates :cache_type, presence: true, inclusion: { in: %w[artists tracks] }
  validates :time_range, presence: true, inclusion: { in: %w[short_term medium_term long_term] }
  validates :data, presence: true

  CACHE_DURATION = 12.hours

  def self.fetch_or_cache(user, type, time_range)
    cache = find_or_initialize_by(
      user_id: user.id,
      cache_type: type,
      time_range: time_range
    )

    # puts "---- Cache found: #{cache.persisted?} ----"
    # puts "---- Last updated: #{cache.last_updated} ----"
    if cache.needs_update?
      cache.update_cache(user)
    end

    cache.data
  end

  def needs_update?
    last_updated.nil? || last_updated < CACHE_DURATION.ago
  end


  def update_cache(user)
    client = user.spotify_service
    new_data = case cache_type
    when "artists"
      client.top_artists(50, time_range)
    when "tracks"
      client.top_tracks(50, time_range)
    end

    update!(
      data: new_data,
      last_updated: Time.current
    )
  end
end
