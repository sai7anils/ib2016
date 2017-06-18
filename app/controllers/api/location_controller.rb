class Api::LocationController < ApplicationController
  def states
    render json: CS.get(params[:country]).to_json
  end

  def cities
    render json: CS.cities(params[:state], params[:country]).to_json
  end

  def subregion_options
    render partial: 'user/registrations/subregion_select'
  end

  def event_subregion_options
    render partial: 'user/events/subregion_select'
  end
end
