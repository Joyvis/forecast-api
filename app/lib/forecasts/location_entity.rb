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
end
