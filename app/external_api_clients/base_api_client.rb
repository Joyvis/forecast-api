require "net/http"

class BaseApiClient
  def get(uri)
    response = Net::HTTP.get_response URI(uri)
    parse_response(response)
  end

  def parse_response(response)
    JSON.parse(response.body)
  end
end
