class LocationsApiClient
  class LocationNotFoundError < StandardError; end

  def self.fetch(address:)
    raise LocationNotFoundError unless address

    Struct.new(:longitude, :latitude).new(1, 2)
  end
end
