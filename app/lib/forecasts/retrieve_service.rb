module Forecasts
  class InvalidParamsError < StandardError; end

  class RetrieveService
    attr_reader :locations_repo, :forecasts_repo

    def initialize(locations_repo: nil, forecasts_repo: nil, zipcode: nil, address: nil)
      @locations_repo = locations_repo
      @forecasts_repo = forecasts_repo
      @zipcode = zipcode
      @address = address
    end

    # TODO: missing aggregate location entity with forecast entity
    def call
      raise InvalidParamsError if @zipcode.nil? && @address.nil?

      return locations_repo.find_by_zipcode(zipcode: @zipcode) if @zipcode

      locations_repo.find_by_address(address: @address)
    end
  end
end
