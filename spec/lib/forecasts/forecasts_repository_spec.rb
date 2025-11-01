require 'rails_helper'

RSpec.describe Forecasts::ForecastsRepository do
  let(:forecasts_api_client) { instance_double(ForecastsApiClient, fetch: double(min_temp: 0, max_temp: 1, current_temp: 2)) }
  subject { described_class.new(forecasts_api_client: forecasts_api_client).find_by_coordinates(latitude: 1, longitude: 1) }

  it 'returns a forecast' do
    expect(subject).to be_a(Forecasts::ForecastEntity)
  end
end
