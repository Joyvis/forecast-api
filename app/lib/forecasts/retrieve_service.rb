module Forecasts
  class InvalidParamsError < StandardError; end

  class RetrieveService
    attr_reader :locations_repo, :forecasts_repo

    def initialize(locations_repo:, forecasts_repo:)
      @locations_repo = locations_repo
      @forecasts_repo = forecasts_repo
    end

    def call(zipcode: nil, address: nil)
      location = fetch_location(zipcode: zipcode, address: address)
      location.forecast = forecast(location: location)
      location
    end

    private

    def forecast(location:)
      forecasts_repo
        .find_by_coordinates(
          latitude: location.latitude,
          longitude: location.longitude
        )
    end

    def fetch_location(zipcode:, address:)
      raise InvalidParamsError if zipcode.nil? && address.nil?

      return locations_repo.find_by_zipcode(zipcode: zipcode) if zipcode

      locations_repo.find_by_address(address: address)
    end
  end
end
