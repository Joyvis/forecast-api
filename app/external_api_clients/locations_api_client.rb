class LocationsApiClient < BaseApiClient
  class LocationNotFoundError < StandardError; end

  # TODO: Setup .env
  BASE_URL = ENV.fetch("LOCATIONS_API_BASE_URL").freeze
  API_KEY = ENV.fetch("LOCATIONS_API_KEY").freeze

  def fetch(address:, force: false)
    raise LocationNotFoundError unless address

    locations = fetch_locations(address:, force:)
    serialize_location(locations)
  end

  def self.fetch(address:, force: false)
    new.fetch(address: address, force: force)
  end

  private

  def serialize_location(locations)
    locations.map do |record|
      Struct
        .new(:longitude, :latitude, :address, :zipcode)
        .new(
          record["lon"],
          record["lat"],
          record["display_name"],
          record["address"]["postcode"]
        )
    end
  end

  def fetch_locations(address:, force:)
    encoded_address = CGI.escape(address)
    Rails.cache.fetch("locations/#{normalize_address(address)}", expires_in: 30.minutes, force: force) do
      get("#{BASE_URL}/search?q=#{encoded_address}&api_key=#{API_KEY}")
    end
  end

  def normalize_address(raw)
    text = raw.to_s.downcase
    text = I18n.transliterate(text)

    text.gsub!(/[.,;:#\-]/, " ")
    text.gsub!(/\s+\d+\b/, "")
    text.gsub!(/\s+/, " ")
    text.strip
  end
end
