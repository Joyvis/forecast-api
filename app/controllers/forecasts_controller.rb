class ForecastsController < ApplicationController
  # BASE_URL/api/v1/forecasts
  def index
    if params[:zipcode].present? || params[:address].present?
      render json: {}, status: :ok
    else
      render status: :bad_request
    end
  end
end
