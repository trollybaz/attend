class Api::ApplicationController < ApplicationController
  include Pundit

  def current_workspace
    key = self.class != Api::WorkspacesController ? :workspace_id : :id
    @current_workspace ||= current_user.workspaces.where(id: params[key]).first
  end
  helper_method :current_workspace

end
