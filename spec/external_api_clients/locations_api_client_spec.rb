require 'rails_helper'

RSpec.describe LocationsApiClient do
  describe '.fetch' do
    subject do
      VCR.use_cassette(location) { described_class.fetch(address: address) }
    end

    context 'when address is present' do
      context 'when the address is a zipcode' do
        let(:address) { '11310-185' }
        let(:location) { 'fetch_by_zipcode' }

        it 'returns a location' do
          expect(subject.first).to be_present
          expect(subject.first.longitude).to eq "-46.3944055"
          expect(subject.first.latitude).to eq "-23.9695936"
        end
      end

      context 'when the address is a full address' do
        let(:address) { 'R. Martim Afonso, 114 - São Vicente' }
        let(:location) { 'fetch_by_address' }

        it 'returns a location' do
          expect(subject.first).to be_present
          expect(subject.first.longitude).to eq "-46.3862272"
          expect(subject.first.latitude).to eq "-23.9677478"
        end
      end

      context 'when address is not found' do
        let(:address) { 'nao encontrada' }
        let(:location) { 'fetch_not_found' }

        it 'returns a not found response' do
          expect(subject).to be_empty
        end
      end
    end

    context 'when address is not present' do
      let(:address) { nil }
      let(:location) { 'fetch_address_not_present' }

      it 'raises LocationNotFoundError' do
        expect { subject }.to raise_error(LocationsApiClient::LocationNotFoundError)
      end
    end
  end
end
