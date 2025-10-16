module Forecasts
  class InvalidParamsError < StandardError; end

  class RetrieveService

    def initialize(zipcode: nil, address: nil)
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
