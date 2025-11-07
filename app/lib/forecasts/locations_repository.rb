module Forecasts
  class LocationEntity
    attr_reader :zipcode, :address, :forecast, :latitude, :longitude

    def initialize(zipcode:, address:, longitude:, latitude:)
      @zipcode = zipcode
      @address = address
      @latitude = latitude
      @longitude = longitude
    end

    def forecast=(forecast)
      @forecast = forecast
    end
  end

  class LocationNotFoundError < StandardError; end

  class LocationsRepository
    attr_reader :locations_api_client

    def initialize(locations_api_client:)
      @locations_api_client = locations_api_client
    end

    def find_by_zipcode(zipcode:)
      raise LocationNotFoundError unless zipcode

      fetch_location(address: zipcode)
    end

    def find_by_address(address:)
      raise LocationNotFoundError unless address

      fetch_location(address: address)
    end

    private

    def fetch_location(address:)
      locations = locations_api_client.fetch(address: address)
      locations.map do |location|
        LocationEntity.new(
          zipcode: location.zipcode,
          address: location.address,
          longitude: location.longitude,
          latitude: location.latitude
        )
      end
    end
  end
end
