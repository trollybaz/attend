class Admin::EventTypesController < ApplicationController
  before_action :set_event_type, only: [:show, :edit, :update, :destroy]

  PERSON_PARAM_FIELDS = ['first_name', 'middle_name', 'last_name', 'email']

  def index
    @event_types = current_workspace.event_types.order(EventType.arel_table[:created_at].desc)
  end

  def new
    @event_type = EventType.new
    @event_type.workspace = current_workspace
    @people = (1..5).map { Person.new }
  end

  def create
    @event_type = EventType.new
    @event_type.workspace = current_workspace
    @event_type.assign_attributes(person_params)

    if @event_type.save
      add_event_type_enrollees
      redirect_to admin_workspace_event_type_url(current_workspace, @event_type), notice: 'Event Type created'  
    else
      render action: :new
    end
  end

  def edit
    @people = (1..5).map { Person.new }
  end

  def show
  end

  def update
    @event_type.assign_attributes(person_params)
    if @event_type.save
      add_event_type_enrollees
      redirect_to admin_workspace_event_type_url(current_workspace, @event_type), notice: 'Event Type updated'  
    else
      render action: :edit
    end
  end

  def destroy
    if @event_type.destroy
      redirect_to admin_workspace_event_types_url(current_workspace), notice: 'Person was successfully destroyed.'
    else
      redirect_to admin_workspace_event_types_url(current_workspace), alert: "Could not delete #{@event_type.name}" 
    end
  end


 private

  def set_event_type
    @event_type = current_workspace.event_types.find(params[:id])
  end

  def person_params
    params.require(:event_type).permit(:name, :description)
  end

  def add_event_type_enrollees

    added_count = 0

    # add newly created participants from text fields
    people = params["person"] || []
    for person in people
      present = !!PERSON_PARAM_FIELDS.detect{ |field| person[field].present? }
      if present
        mock_params = ActionController::Parameters.new(person: person).require(:person).permit(*PERSON_PARAM_FIELDS)
        person = Person.new(mock_params)
        added_count += 1 if person.save
      end
    end
     
    # TODO: add newly created participants from textarea

    # add existing people to roster
    if ids = params["participant_ids"]
      people = current_workspace.people.where(id: ids)
      # TODO: Consider first_or_build: http://stackoverflow.com/a/18724458
      for person in people
        DEBUG_LOG.debug @event_type.enrollees << person
      end
    end

  end
  
end

