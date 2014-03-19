class Admin::PeopleController < Admin::ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  def index
    @people = Person.all
  end

  # GET /people/1
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  def create
    @person = Person.new(person_params)
    @person.workspace_id = current_workspace.id

    if @person.save
      redirect_to admin_workspace_person_url(current_workspace, @person), notice: 'Person was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /people/1
  def update
    if @person.update(person_params)
      redirect_to admin_workspace_person_url(current_workspace, @person), notice: 'Person was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy
    redirect_to admin_workspace_people_url(current_workspace), notice: 'Person was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      # TODO: Requires security check
      @person = Person.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def person_params
      params.require(:person).permit(:first_name, :middle_name, :last_name, :email)
    end
end
