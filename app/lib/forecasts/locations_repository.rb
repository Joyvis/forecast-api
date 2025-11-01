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
    def find_by_zipcode(zipcode:)
      raise LocationNotFoundError unless zipcode

      LocationEntity.new(zipcode: zipcode, address: zipcode, longitude: 0, latitude: 0)
    end

    def find_by_address(address:)
      raise LocationNotFoundError unless address

      LocationEntity.new(zipcode: address, address: address, longitude: 0, latitude: 0)
    end
  end
end
