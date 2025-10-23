class ForecastsController < ApplicationController
  rescue_from Forecasts::InvalidParamsError, with: :render_error
  rescue_from Forecasts::LocationNotFoundError, with: :render_error

  def index
    locations_repo = Forecasts::LocationsRepository.new
    result = Forecasts::RetrieveService.new(
      locations_repo: locations_repo,
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
