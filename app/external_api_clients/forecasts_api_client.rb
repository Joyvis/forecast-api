class ForecastsApiClient < BaseApiClient
  class ForecastNotFoundError < StandardError; end

  BASE_URL = ENV.fetch('FORECASTS_API_BASE_URL').freeze
  API_KEY = ENV.fetch('FORECASTS_API_KEY').freeze

  def fetch(longitude:, latitude:, force: false)
    raise ForecastNotFoundError unless longitude.present? && latitude.present?

    forecast = fetch_forecast(longitude:, latitude:, force:)
    raise ForecastNotFoundError if forecast['error'].present?

    serialize_forecast(forecast)
  end

  def self.fetch(longitude:, latitude:)
    new.fetch(longitude: longitude, latitude: latitude)
  end

  private

  def serialize_forecast(forecast)
    current_conditions = forecast['currentConditionsHistory']
    Struct
      .new(:max_temp, :min_temp, :current_temp)
      .new(
        current_conditions['maxTemperature']['degrees'],
        current_conditions['minTemperature']['degrees'],
        forecast['temperature']['degrees']
      )
  end

  def fetch_forecast(longitude:, latitude:, force:)
    key = cache_key(longitude: longitude, latitude: latitude)
    Rails.cache.fetch(key, expires_in: 30.minutes, force: force) do
      get("#{BASE_URL}/currentConditions:lookup?key=#{API_KEY}&location.latitude=#{latitude}&location.longitude=#{longitude}")
    end
  end

  def cache_key(longitude:, latitude:)
    resolution = 0.05
    long_grid = (longitude.to_f / resolution).round * resolution
    lat_grid = (latitude.to_f / resolution).round * resolution

    "forecast/#{long_grid},#{lat_grid}"
  end
end
