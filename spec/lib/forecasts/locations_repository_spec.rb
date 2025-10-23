require 'rails_helper'

RSpec.describe Forecasts::LocationsRepository do
  describe '#find_by_zipcode' do
    subject { described_class.new.find_by_zipcode(zipcode: zipcode) }

    context 'when zipcode is valid' do
      let(:zipcode) { '12345' }

      it 'returns an instance of location entity' do
        is_expected.to be_a Forecasts::LocationEntity
      end
    end
  end

  describe '#find_by_address' do
  end
end
