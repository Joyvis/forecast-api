require 'rails_helper'

RSpec.describe LocationsApiClient do
  describe '.fetch' do
    subject { described_class.fetch(address: address) }

    context 'when address is present' do
      let(:address) { 'address' }

      it 'returns a location' do
        expect(subject).to be_present
        expect(subject.longitude).to be_present
        expect(subject.latitude).to be_present
      end
    end

    context 'when address is not present' do
      let(:address) { nil }

      it 'raises LocationNotFoundError' do
        expect { subject }.to raise_error(LocationsApiClient::LocationNotFoundError)
      end
    end
  end
end
