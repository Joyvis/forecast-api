require 'rails_helper'

RSpec.describe Forecasts::LocationsRepository do
  describe '#find_by_zipcode' do
    subject { described_class.new.find_by_zipcode(zipcode: zipcode) }

    context 'when zipcode is valid' do
      let(:zipcode) { '12345' }

      it 'returns an instance of location entity' do
        is_expected.to be_a Forecasts::LocationEntity
      end

      it 'ensures location entity contract' do
        # TODO: programatically improve testability with a factory
        expect(subject.zipcode).to eq zipcode
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
  end
end
