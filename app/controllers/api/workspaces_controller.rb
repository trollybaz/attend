class Api::WorkspacesController < Api::ApplicationController
  before_action :set_workspace,        except: [:index, :create]
  before_filter :check_workspace,      except: [:index, :create]
  # pundit verifications
  after_action  :verify_authorized,    only: [:create, :destroy]
  after_filter  :verify_policy_scoped, only: :index

  def index
    # type of a shorthand for:
    # @workspaces = WorkspacePolicy::Scope.new(current_user, Workspace).resolve.order(:name)
    # but also sets something that allows verify_policy_scoped to pass
    @workspaces = policy_scope(Workspace).order(:name)

    render json: Workspaces::ExtendedSerializer.collection(@workspaces)
  end

  def create
    @workspace = current_user.build_new_workspace
    authorize @workspace
    params.require(:workspace).permit(:name)
    @workspace.assign_attributes(params)
    if @workspace.save
      return render json: Workspaces::ExtendedSerializer.new(@workspace)
    else
      return render json: @workspace.errors, status: :unprocessable_entity
    end
  end

  def show
    # current_workspace is already "authorized" by default
    render json: Workspaces::ExtendedSerializer.new(@workspace)
  end

  def update
    # current_workspace is already "authorized" by default
    workspace_params = params.require(:workspace).permit(:name)
    @workspace.assign_attributes(workspace_params)
    if @workspace.save
      return render json: Workspaces::ExtendedSerializer.new(@workspace)
    else
      return render json: @workspace.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # TODO: If we do the authorize check in an after_action, will
    # the workspace already be destroyed by then?

    authorize @workspace
    render head: :unprocessable_entity # disable for now
  end

 private

  # Use callbacks to share common setup or constraints between actions.
  def set_workspace
    @workspace = current_workspace
  end

  def check_workspace
    head :not_found if !@workspace
  end
end
