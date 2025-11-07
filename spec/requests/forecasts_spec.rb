require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  describe "GET /index" do
    BASE_URL = '/forecasts'.freeze

    before do
      VCR.use_cassette(location) { get url }
    end

    context "with valid query params" do
      context 'with zipcode' do
        let(:url) { "#{BASE_URL}?zipcode=11310-185" }
        let(:location) { 'request_fetch_by_zipcode' }

        it 'renders a json response with http status ok' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'with address' do
        let(:url) { "#{BASE_URL}?address=#{CGI.escape 'R. Martim Afonso, 114 - São Vicente'}" }
        let(:location) { 'request_fetch_by_address' }

        it 'renders a json response with http status ok' do
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context "with invalid query params" do
      let(:url) { "#{BASE_URL}" }
      let(:location) { 'request_fetch_not_found' }

      it 'renders a json response with http status bad request' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
