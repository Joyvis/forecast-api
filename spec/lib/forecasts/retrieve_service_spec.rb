require 'rails_helper'

RSpec.describe Forecasts::RetrieveService do
  describe '#call' do
    let(:zipcode) { nil }
    let(:address) { nil }

    subject {
      described_class.new(zipcode: zipcode, address: address).call
    }

    context 'when zipcode is present' do
      let(:zipcode) { '1122200' }

      it 'returns forecast data by zipcode' do
        expect(subject).to eq({ temperature: 12 })
      end
    end

    context 'when address is present' do
      let(:address) { 'foobar' }

      it 'returns forecast data by address' do
        expect(subject).to eq({ temperature: 12 })
      end
    end

    context 'when zipcode and address are present' do
      let(:zipcode) { '1122200' }
      let(:address) { 'foobar' }

      it 'returns forecast data by zipcode' do
        expect(subject).to eq({ temperature: 12 })
      end
    end

    context 'when zipcode and address are not present' do
      it 'returns forecast data' do
        expect { subject }.to raise_error(Forecasts::InvalidParamsError)
      end
    end
  end
end
