module Forecasts
  class LocationEntity
    attr_reader :zipcode

    def initialize(zipcode:)
      @zipcode = zipcode
    end
  end

  class LocationNotFoundError < StandardError; end

  class LocationsRepository
    def find_by_zipcode(zipcode:)
      raise LocationNotFoundError unless zipcode

      LocationEntity.new(zipcode: zipcode)
    end
  end
end
