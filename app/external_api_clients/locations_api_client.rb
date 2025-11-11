class LocationsApiClient < BaseApiClient
  class LocationNotFoundError < StandardError; end

  # TODO: Setup .env
  BASE_URL = 'https://geocode.maps.co'.freeze
  API_KEY = '69064e708e757160819707mts747e8c'.freeze

  def fetch(address:)
    address = CGI.escape(address)
    response = get("#{BASE_URL}/search?q=#{address}&api_key=#{API_KEY}")

    response.map do |record|
      Struct
        .new(:longitude, :latitude, :address, :zipcode)
        .new(record['lon'], record['lat'], record['display_name'], record['address']['postcode'])
    end
  end

  def self.fetch(address:)
    # TODO: instance method is not validating presence
    raise LocationNotFoundError unless address

    new.fetch(address: address)
  end
end
