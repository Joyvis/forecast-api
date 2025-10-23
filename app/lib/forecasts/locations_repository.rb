module Forecasts
  class LocationEntity
    attr_reader :zipcode, :address, :forecast

    def initialize(zipcode:, address:)
      @zipcode = zipcode
      @address = address
    end

    def forecast=(forecast)
      @forecast = forecast
    end
  end

  class LocationNotFoundError < StandardError; end

  class LocationsRepository
    def find_by_zipcode(zipcode:)
      raise LocationNotFoundError unless zipcode

      LocationEntity.new(zipcode: zipcode, address: zipcode)
    end
  end
end
