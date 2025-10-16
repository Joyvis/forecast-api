class ForecastsController < ApplicationController
  # BASE_URL/api/v1/forecasts
  def index
    render json: {}, status: :ok
  end
end
