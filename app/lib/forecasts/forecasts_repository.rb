module Forecasts
  class ForecastEntity
    attr_reader :min_temp, :max_temp, :current_temp

    def initialize(min_temp:, max_temp:, current_temp:)
      @min_temp = min_temp
      @max_temp = max_temp
      @current_temp = current_temp
    end
  end

  class ForecastsRepository
    attr_reader :forecasts_api_client

    def initialize(forecasts_api_client:)
      @forecasts_api_client = forecasts_api_client
    end

    def find_by_coordinates(latitude:, longitude:)
      forecast = forecasts_api_client.fetch(latitude: latitude, longitude: longitude)

      ForecastEntity
        .new(
          min_temp: forecast.min_temp,
          max_temp: forecast.max_temp,
          current_temp: forecast.current_temp
        )
    end
  end
end
