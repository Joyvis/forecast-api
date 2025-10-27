require 'rails_helper'

RSpec.describe Forecasts::ForecastsRepository do
  subject { described_class.new.find_by_coordinates(latitude: 1, longitude: 1) }

  it 'returns a forecast' do
    expect(subject).to be_a(Forecasts::ForecastEntity)
  end
end
