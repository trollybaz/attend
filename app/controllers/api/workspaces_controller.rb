class Api::WorkspacesController < Api::ApplicationController
  before_action :set_workspace,        except: [:index, :create]
  after_action  :verify_authorized,    only: [:create, :destroy]
  after_action  :verify_policy_scoped, only: :index

  def index
    @workspaces = PostPolicy::Scope.new(current_user, Workspace).resolve
  end

  def create
    @workspace = Workspace.new
    authorize @workspace
    params.require(:workspace).permit(:name)
    @workspace.assign_attributes(params)

    # render json: Workspace::ExtendedSerializer.new(@workspace)
  end
 
  def show
    # current_workspace is already "authorized" by default
  end

  def update
    # current_workspace is already "authorized" by default
  end

  def destroy
    authorize @workspace
  end
 
 private

  # Use callbacks to share common setup or constraints between actions.
  def set_workspace
    @workspace = current_workspace
  end  
end
