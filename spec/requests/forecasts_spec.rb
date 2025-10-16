require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  describe "GET /index" do
    BASE_URL = '/forecasts'.freeze

    before { get url }

    context "with valid query params" do
      context 'with zipcode' do
        let(:url) { "#{BASE_URL}?zipcode=11222000" }

        it 'renders a json response with http status ok' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'with address' do
        let(:url) { "#{BASE_URL}?address=foobar" }

        it 'renders a json response with http status ok' do
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context "with invalid query params" do
      let(:url) { "#{BASE_URL}" }

      it 'renders a json response with http status bad request' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
