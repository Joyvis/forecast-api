require 'rails_helper'

RSpec.describe ForecastsApiClient do
  describe '.fetch' do
    let(:longitude) { nil }
    let(:latitude) { nil }

    subject do
      VCR.use_cassette(forecast) do
        described_class.fetch(longitude: longitude, latitude: latitude)
      end
    end

    context 'when longitude and latitude are present' do
      let(:forecast) { 'forecast_fetch_by_coordinates' }
      let(:longitude) { '-49.280580736137814' }
      let(:latitude) { '-25.452668606410313' }

      it 'returns a forecast' do
        expect(subject).to be_a(Struct)
        expect(subject.max_temp).to be_present
        expect(subject.min_temp).to be_present
        expect(subject.current_temp).to be_present
      end
    end

    context 'with invalid longitude and latitude' do
      let(:forecast) { 'forecast_fetch_with_invalid_coordinates' }
      let(:longitude) { 'foo' }
      let(:latitude) { 'bar' }

      it 'returns a empty response' do
        expect { subject }.to raise_error(ForecastsApiClient::ForecastNotFoundError)
      end
    end

    context 'when longitude and latitude are not present' do
      let(:forecast) { 'forecast_fetch_not_found_error' }
      let(:longitude) { '-49.280580736137814' }
      let(:latitude) { '' }

      it 'raises a not found error' do
        expect { subject }.to raise_error(ForecastsApiClient::ForecastNotFoundError)
      end
    end
  end
end
