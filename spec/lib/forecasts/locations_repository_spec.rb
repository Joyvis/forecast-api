require 'rails_helper'

RSpec.describe Forecasts::LocationsRepository do
  describe '#find_by_zipcode' do
    subject { described_class.new.find_by_zipcode(zipcode: zipcode) }

    # TODO: potential candidate to be a shared example
    context 'when zipcode is valid' do
      let(:zipcode) { '12345' }

      it 'returns an instance of location entity' do
        is_expected.to be_a Forecasts::LocationEntity
      end

      it 'ensures location entity contract' do
        # TODO: programatically improve testability with a factory
        expect(subject.zipcode).to eq zipcode
        expect(subject.address).to eq zipcode
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
    subject { described_class.new.find_by_address(address: address) }

    context 'when address is present' do
      context 'with a valid address' do
        let(:address) { 'foobar, 123' }

        it 'returns an instance of location entity' do
          is_expected.to be_a Forecasts::LocationEntity
        end

        it 'ensures location entity contract' do
          expect(subject.zipcode).to eq address
          expect(subject.address).to eq address
        end
      end
    end

    context 'when address is missing' do
    end
  end
end
