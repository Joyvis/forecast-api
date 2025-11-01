class ForecastsApiClient
  def fetch(longitude:, latitude:)
    Struct.new(:max_temp, :min_temp, :current_temp).new(1, 2, 3)
  end

  def self.fetch(longitude:, latitude:)
    new.fetch(longitude: longitude, latitude: latitude)
  end
end
