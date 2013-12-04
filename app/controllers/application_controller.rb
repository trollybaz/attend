class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
 
  def current_workspace
    @current_workspace ||= current_user.workspaces.where(id: params[:workspace_id]).first
  end
  helper_method :current_workspace


end
