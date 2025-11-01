class LocationsApiClient
  class LocationNotFoundError < StandardError; end

  def fetch(address:)
    Struct.new(:longitude, :latitude, :address, :zipcode).new(1, 2, 'foobar', '12345')
  end

  def self.fetch(address:)
    raise LocationNotFoundError unless address

    # TODO: fetch real external data
    new.fetch(address: address)
  end
end
