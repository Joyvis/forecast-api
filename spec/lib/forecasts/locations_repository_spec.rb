require 'rails_helper'

RSpec.describe Forecasts::LocationsRepository do
  let(:location_api_mock) { instance_double(LocationsApiClient, fetch: [double(zipcode: '12345', address: 'foobar', longitude: 0, latitude: 1)]) }
  let(:locations_repo) { described_class.new(locations_api_client: location_api_mock) }

  describe '#find_by_zipcode' do
    subject { locations_repo.find_by_zipcode(zipcode: zipcode) }

    # TODO: potential candidate to be a shared example
    context 'when zipcode is valid' do
      let(:zipcode) { '12345' }

      it 'returns an instance of location entity' do
        expect(subject.first).to be_a Forecasts::LocationEntity
      end

      it 'ensures location entity contract' do
        # TODO: programatically improve testability with a factory
        expect(subject.first.zipcode).to eq location_api_mock.fetch(address: zipcode).first.zipcode
        expect(subject.first.address).to eq location_api_mock.fetch(address: zipcode).first.address
      end
    end

    context 'when zipcode is missing' do
      let(:zipcode) { nil }

      it 'returns an instance of location entity' do
        expect { subject }.to raise_error Forecasts::LocationNotFoundError
      end
    end
  end

  describe '#find_by_address' do
    subject { locations_repo.find_by_address(address: address) }

    context 'when address is present' do
      context 'with a valid address' do
        let(:address) { 'foobar, 123' }

        it 'returns an instance of location entity' do
          expect(subject.first).to be_a Forecasts::LocationEntity
        end

        it 'ensures location entity contract' do
          expect(subject.first.zipcode).to eq location_api_mock.fetch(address: address).first.zipcode
          expect(subject.first.address).to eq location_api_mock.fetch(address: address).first.address
        end
      end
    end

    context 'when address is missing' do
    end
  end
end
