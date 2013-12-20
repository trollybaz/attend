module Invitations
  extend ActiveSupport::Concern

  # creates a new user by email, and invites the new user to the provided workspace
  def self.create_and_invite_user_by_email!(inviter_user, invitee_email, workspace)
    ActiveRecord::Base.transaction do
      invitee = build_new_invitee_by_email(invitee_email, workspace)
      invitee.save!
      email_invite(inviter_user, invitee, workspace)
    end
  end

  def self.build_new_invitee_by_email(invitee_email, workspace)
    invitee = User.new
    invitee.invitation_token = SecureRandom.hex
    invitee.email = invitee_email
    invitee.workspaces << workspace
    invitee.password = Devise.friendly_token
    invitee
  end

  def self.email_invite(inviter_user, invitee_user, workspace)
    # TODO: delayed queue
    RegistrationMailer.invitation_workspace_email(inviter_user: inviter_user,
       invitee_user: invitee_user, workspace: workspace)
  end

  ### Mixin methods (currently only affects users)

  def invitation_link
    #TODO: use a config file setting
    hostname = ENV['BASE_URL'] || 'http://localhost:3000'
    # user_url = Rails.application.routes.url_helpers.user_url(invitee_user)
    # "#{user_url}/complete_invitation/#{invitee_user.invitation_token}"
    "#{hostname}/#{self.class.name.tableize}/#{self.id}/complete_invitation/#{self.invitation_token}"
  end

end
