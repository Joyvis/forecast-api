module Forecasts
  class ForecastEntity
    attr_reader :latitude, :longitude

    def initialize(latitude:, longitude:)
      @latitude = latitude
      @longitude = longitude
    end
  end

  class ForecastsRepository
    def find_by_coordinates(latitude:, longitude:)
      ForecastEntity.new(latitude: latitude, longitude: longitude)
    end
  end
end
