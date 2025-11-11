class LocationsApiClient < BaseApiClient
  class LocationNotFoundError < StandardError; end

  # TODO: Setup .env
  BASE_URL = 'https://geocode.maps.co'.freeze
  API_KEY = '69064e708e757160819707mts747e8c'.freeze

  def fetch(address:, force: false)
    raise LocationNotFoundError unless address

    encoded_address = CGI.escape(address)
    response = Rails.cache.fetch("locations/#{normalize_address(address)}", expires_in: 30.minutes, force: force) do
      get("#{BASE_URL}/search?q=#{encoded_address}&api_key=#{API_KEY}")
    end

    response.map do |record|
      Struct
        .new(:longitude, :latitude, :address, :zipcode)
        .new(record['lon'], record['lat'], record['display_name'], record['address']['postcode'])
    end
  end

  def self.fetch(address:, force: false)
    new.fetch(address: address, force: force)
  end

  private

  def normalize_address(raw)
    text = raw.to_s.downcase
    text = I18n.transliterate(text)

    text.gsub!(/[.,;:#\-]/, ' ')
    text.gsub!(/\s+\d+\b/, '')
    text.gsub!(/\s+/, ' ')
    text.strip
  end
end
