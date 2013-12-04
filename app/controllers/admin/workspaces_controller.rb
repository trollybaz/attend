class Admin::WorkspacesController < ApplicationController
  before_action :set_workspace, only: [:show]

  def index
    @workspaces = Workspace.order('created_at')
  end

  def show
  end
 
 private

  # Use callbacks to share common setup or constraints between actions.
  def set_workspace
    # TODO: Requires security check
    @workspace = Workspace.find(params[:id])
  end  

end
