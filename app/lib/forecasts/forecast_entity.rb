module Forecasts
  class ForecastEntity
    attr_reader :min_temp, :max_temp, :current_temp

    def initialize(min_temp:, max_temp:, current_temp:)
      @min_temp = min_temp
      @max_temp = max_temp
      @current_temp = current_temp
    end
  end
end
