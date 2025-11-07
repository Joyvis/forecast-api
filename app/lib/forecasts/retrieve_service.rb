module Forecasts
  class InvalidParamsError < StandardError; end

  class RetrieveService
    attr_reader :locations_repo, :forecasts_repo

    def initialize(locations_repo:, forecasts_repo:)
      @locations_repo = locations_repo
      @forecasts_repo = forecasts_repo
    end

    def call(zipcode: nil, address: nil)
      locations = fetch_locations(zipcode: zipcode, address: address)
      locations.map do |location|
        location.forecast = forecast(location: location)
        location
      end
    end

    private

    def forecast(location:)
      forecasts_repo
        .find_by_coordinates(
          latitude: location.latitude,
          longitude: location.longitude
        )
    end

    def fetch_locations(zipcode:, address:)
      raise InvalidParamsError if zipcode.nil? && address.nil?

      return locations_repo.find_by_zipcode(zipcode: zipcode) if zipcode

      locations_repo.find_by_address(address: address)
    end
  end
end
