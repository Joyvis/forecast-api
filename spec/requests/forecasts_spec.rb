require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  describe "GET /index" do
    before { get '/forecasts?zipcode=11999111' }

    context "with valid query params" do
      it 'renders a json response with http status ok' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
