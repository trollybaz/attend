class User < ActiveRecord::Base
  include Invitations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships
  has_many :workspaces, through: :memberships

  validate :has_workspace?, on: :create

  ### Utility methods ###

#  def name=(name)
#    parts = name.split(/\s+/).reject{|s|s.blank?}
#
#    if parts.length > 0
#      self.first_name = parts[0]
#    end
# 
#    if parts.length > 1   
#      self.last_name = parts[1..parts.length-1].join(' ')
#    end
#  end
#
#  def name
#    "#{first_name} #{last_name}"
#  end
  
  def setup_workspace_for_new_user!
    workspace = workspaces.build
    workspace.name = email + "'s Attendance"
    self.save!
  end

 private

  def has_workspace?
    # TODO: Not ideal, but should only be called on user creation
    if !workspaces.any?
      errors.add(:memberships, 'count needs to be > 0')
    end 
  end

end
