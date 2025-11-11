require 'rails_helper'

RSpec.describe Forecasts::ForecastEntity do
  let(:forecast) { described_class.new(min_temp: 10, max_temp: 20, current_temp: 15) }

  it 'responds a populated object' do
    expect(forecast.min_temp).to eq(10)
    expect(forecast.max_temp).to eq(20)
    expect(forecast.current_temp).to eq(15)
  end
end
