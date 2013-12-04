class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships
  has_many :workspaces, through: :memberships

  validate :has_workspace?, on: :create



  ### Utility methods ###
  
  def setup_workspace_for_new_user!
    workspace = workspaces.build
    workspace.name = email + "'s Attendance"
    self.save!
  end

 private

  def has_workspace?
    if memberships.count <= 0
      errors.add(:memberships, 'count needs to be > 0')
    end 
  end

end
