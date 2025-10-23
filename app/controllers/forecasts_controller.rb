class ForecastsController < ApplicationController
  rescue_from Forecasts::InvalidParamsError, with: :render_error

  def index
    # locations_repo = receive a zipcode or an address and return complementary info and coordinates
    result = Forecasts::RetrieveService.new(
      zipcode: params[:zipcode],
      address: params[:address]
    ).call

    render json: result, status: :ok
  end

  private

  def render_error
    # TODO: improve error message
    render status: :bad_request
  end
end
