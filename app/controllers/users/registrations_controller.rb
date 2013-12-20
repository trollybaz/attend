class Users::RegistrationsController < Devise::RegistrationsController

  def complete_invitation
    user_id         = params[:id]
    invitation_token = params[:invitation_token]

    # TODO: Add require_no_authentication for complete_invitation
    user = User.find(user_id)
    if invitation_token.present? && user && user.invitation_token == invitation_token
      self.resource = user
    end
  end

  def complete_invitation_update
    user_id          = params[:id]
    invitation_token = params[:user][:invitation_token]
    
    # current_user should be nil; shouldn't authenticate
    byebug
    return if current_user

    # TODO: Add require_no_authentication for complete_invitation_update
    user = User.find(user_id)
    if invitation_token.present? && user && user.invitation_token == invitation_token
      user.password              = params[:user][:password]
      user.password_confirmation = params[:user][:password_conf]
      user.invitation_token      = nil
      user.save!

      sign_in user

      # redirect to the app
      # TODO: root_url doesn't work?
      redirect_to '/'	
    else
      # user id and token don't match!
    end
  end


  def build_resource(hash=nil)
    # if the Devise controller is trying to create a new user,
    # then build a new workspace to go along with it
    super 
    if action_name == 'create'
      self.resource.workspaces.build
    end
    self.resource
  end

end
