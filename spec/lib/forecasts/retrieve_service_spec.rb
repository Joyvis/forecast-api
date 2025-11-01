require 'rails_helper'

RSpec.describe Forecasts::RetrieveService do
  describe '#call' do
    let(:zipcode) { nil }
    let(:address) { nil }
    let(:forecast) do
      Forecasts::ForecastEntity.new(min_temp: 0, max_temp: 0, current_temp: 0)
    end
    let(:location) do
      Forecasts::LocationEntity.new(zipcode: zipcode, address: address, longitude: 0, latitude: 0)
    end

    let(:locations_repo) do
      instance_double(Forecasts::LocationsRepository, find_by_zipcode: location, find_by_address: location)
    end

    let(:forecasts_repo) do
      instance_double(Forecasts::ForecastsRepository, find_by_coordinates: forecast)
    end

    subject do
      described_class
        .new(locations_repo: locations_repo, forecasts_repo: forecasts_repo)
        .call(zipcode: zipcode, address: address)
    end

    # TODO: fix assertions
    context 'when zipcode is present' do
      let(:zipcode) { '1122200' }

      it 'returns forecast data by zipcode' do
        expect(subject).to be_a(Forecasts::LocationEntity)
        expect(subject.forecast).to be_present
        expect(subject.forecast).to be_a(Forecasts::ForecastEntity)
      end
    end

    context 'when address is present' do
      let(:address) { 'foobar' }

      it 'returns forecast data by address' do
        expect(subject).to be_a(Forecasts::LocationEntity)
        expect(subject.forecast).to be_present
        expect(subject.forecast).to be_a(Forecasts::ForecastEntity)
      end
    end

    context 'when zipcode and address are present' do
      let(:zipcode) { '1122200' }
      let(:address) { 'foobar' }

      it 'returns forecast data by zipcode' do
        expect(subject).to be_a(Forecasts::LocationEntity)
        expect(subject.forecast).to be_present
        expect(subject.forecast).to be_a(Forecasts::ForecastEntity)
      end
    end

    context 'when zipcode and address are not present' do
      it 'returns forecast data' do
        expect { subject }.to raise_error(Forecasts::InvalidParamsError)
      end
    end
  end
end
