class RegistrationMailer < ActionMailer::Base
  def invitation_workspace_email(inviter_user: nil, invitee_user: nil, workspace: nil)
    @inviter_user = inviter_user
    @invitee_user = invitee_user
    @workspace    = workspace
    mail_opts = {
      from:   inviter_user.email,
      to:     invitee_user.email,
      subject: "You have been invited to Workspace: #{workspace.name}",
    }

    mail mail_opts
  end
end
