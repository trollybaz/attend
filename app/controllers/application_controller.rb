class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  def current_workspace
    key = self.class != Api::WorkspacesController ? :workspace_id : :id
    @current_workspace ||= current_user.workspaces.where(id: params[key]).first
  end
  helper_method :current_workspace


end
