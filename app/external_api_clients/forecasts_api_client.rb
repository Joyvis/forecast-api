class ForecastsApiClient < BaseApiClient
  class ForecastNotFoundError < StandardError; end

  BASE_URL = 'https://weather.googleapis.com/v1'.freeze
  API_KEY = 'AIzaSyCzpoodrZZOAFbMq4-Lj2CgGeRxCZZvO0I'.freeze

  def fetch(longitude:, latitude:)
    raise ForecastNotFoundError unless longitude.present? && latitude.present?

    forecast = get("#{BASE_URL}/currentConditions:lookup?key=#{API_KEY}&location.latitude=#{latitude}&location.longitude=#{longitude}")

    raise ForecastNotFoundError if forecast['error'].present?

    current_conditions = forecast['currentConditionsHistory']
    Struct
      .new(:max_temp, :min_temp, :current_temp)
      .new(
        current_conditions['maxTemperature']['degrees'],
        current_conditions['minTemperature']['degrees'],
        forecast['temperature']['degrees']
      )
  end

  def self.fetch(longitude:, latitude:)
    new.fetch(longitude: longitude, latitude: latitude)
  end
end
