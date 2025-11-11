require 'rails_helper'

RSpec.describe Forecasts::LocationEntity do
  let(:subject) do
    described_class
      .new(
        zipcode: '12345',
        address: '123 Main St',
        longitude: 0,
        latitude: 0
      )
  end

  it 'returns a populated object' do
    expect(subject.zipcode).to eq('12345')
    expect(subject.address).to eq('123 Main St')
    expect(subject.longitude).to eq(0)
    expect(subject.latitude).to eq(0)
  end

  describe '#forecast=' do
    it 'sets the forecast' do
      forecast = instance_double(Forecasts::ForecastEntity)
      subject.forecast = forecast
      expect(subject.forecast).to eq(forecast)
    end
  end
end
