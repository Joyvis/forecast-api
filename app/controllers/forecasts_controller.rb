class ForecastsController < ApplicationController
  rescue_from Forecasts::InvalidParamsError, with: :render_error
  rescue_from Forecasts::LocationNotFoundError, with: :render_error

  # TODO: refact this method
  def index
    locations_repo = Forecasts::LocationsRepository.new
    forecasts_repo = Forecasts::ForecastsRepository.new

    result = Forecasts::RetrieveService.new(
      locations_repo: locations_repo,
      forecasts_repo: forecasts_repo,
    ).call(zipcode: params[:zipcode], address: params[:address])

    render json: result, status: :ok
  end

  private

  def render_error
    # TODO: improve error message
    render status: :bad_request
  end
end
