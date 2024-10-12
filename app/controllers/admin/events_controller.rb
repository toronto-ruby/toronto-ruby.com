module Admin
  class EventsController < BaseController
    before_action :set_event, only: %i[show edit update destroy]
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
      @events = Event.all.order(created_at: :desc)
    end

    def new
      @event = Event.new
    end

    # GET /events/1/edit
    def edit; end

    # GET /events/1
    def show; end

    # POST /events or /events.json
    def create
      @event = Event.new(event_params)
      @event.start_at = ActiveSupport::TimeZone.new('Eastern Time (US & Canada)').local_to_utc(@event.start_at)

      respond_to do |format|
        if @event.save
          format.html { redirect_to admin_events_path, notice: 'Event was successfully created.' }
          format.json { render json: { success: true }, status: :created }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /events/1 or /events/1.json
    def update
      @event.assign_attributes(event_params)
      @event.start_at = ActiveSupport::TimeZone.new('Eastern Time (US & Canada)').local_to_utc(@event.start_at)

      respond_to do |format|
        if @event.save
          format.html { redirect_to admin_events_path, notice: 'Event was successfully updated.' }
          format.json { render :show, status: :ok, location: @event }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /events/1 or /events/1.json
    def destroy
      @event.destroy!

      respond_to do |format|
        format.html { redirect_to admin_events_path, notice: 'Event was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find_by!(slug: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :rsvp_link, :location, :description, :sponsor, :sponsor_link,
                                    :sponsor_logo, :start_at, :status)
    end

    def record_not_found
      redirect_to admin_events_path, warning: 'Event not found'
    end
  end
end
