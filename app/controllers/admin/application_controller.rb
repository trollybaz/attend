class Admin::ApplicationController < ApplicationController

  def current_workspace
    key = self.class != Admin::WorkspacesController ? :workspace_id : :id
    @current_workspace ||= Workspace.where(id: params[key]).first
  end
  helper_method :current_workspace

end
