require 'rails_helper'

RSpec.describe ForecastsApiClient do
  describe '.fetch' do
    let(:longitude) { nil }
    let(:latitude) { nil }

    subject { described_class.fetch(longitude: longitude, latitude: latitude) }

    context 'when longitude and latitude are present' do
      let(:longitude) { 1 }
      let(:latitude) { 2 }

      it 'returns a forecast' do
        expect(subject).to be_present
        expect(subject.max_temp).to be_present
        expect(subject.min_temp).to be_present
        expect(subject.current_temp).to be_present
      end
    end
  end
end
