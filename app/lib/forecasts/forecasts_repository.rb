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
    def find_by_coordinates(latitude:, longitude:)
      # TODO: fetch data from external API
      ForecastEntity.new(min_temp: 0, max_temp: 0, current_temp: 0)
    end
  end
end
