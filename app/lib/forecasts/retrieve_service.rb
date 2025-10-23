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

    def call
      raise InvalidParamsError if @zipcode.nil? && @address.nil?


      {
        temperature: 12
      }
    end
  end
end
