class ForecastsController < ApplicationController
  rescue_from Forecasts::InvalidParamsError, with: :render_error

  def index
    result = Forecasts::RetrieveService.new(
      zipcode: params[:zipcode],
      address: params[:address]
    ).call

    render json: result, status: :ok
  end

  private

  def render_error
    render status: :bad_request
  end
end
