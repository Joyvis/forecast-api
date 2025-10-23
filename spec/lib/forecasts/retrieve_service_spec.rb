require 'rails_helper'

RSpec.describe Forecasts::RetrieveService do
  describe '#call' do
    let(:zipcode) { nil }
    let(:address) { nil }
    let(:locations_repo) do
      instance_double(Forecasts::LocationsRepository, find_by_zipcode: zipcode, find_by_address: address)
    end

    subject {
      described_class.new(locations_repo: locations_repo, zipcode: zipcode, address: address).call
    }

    context 'when zipcode is present' do
      let(:zipcode) { '1122200' }

      it 'returns forecast data by zipcode' do
        expect(subject).to eq zipcode
      end
    end

    context 'when address is present' do
      let(:address) { 'foobar' }

      it 'returns forecast data by address' do
        expect(subject).to eq address
      end
    end

    context 'when zipcode and address are present' do
      let(:zipcode) { '1122200' }
      let(:address) { 'foobar' }

      it 'returns forecast data by zipcode' do
        expect(subject).to eq zipcode
      end
    end

    context 'when zipcode and address are not present' do
      it 'returns forecast data' do
        expect { subject }.to raise_error(Forecasts::InvalidParamsError)
      end
    end
  end
end
