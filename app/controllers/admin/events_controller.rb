class Admin::EventsController < Admin::ApplicationController
  include ApplicationHelper
  include Admin::AdminEvent
  before_action :load_event, only: [:edit, :update]

  def index
    @events = search_events(params)
  end

  def edit; end

  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to edit_admin_event_path, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    respond_to do |format|
      format.json { render json: true}
    end
  end

  private

  def event_params
    params.require(:event).permit!
  end

  def search_events(params)
    load_events(params)
  end

  def load_event
    @event = Event.find(params[:id])
  end
end
