class Workspace < ActiveRecord::Base

  has_many :memberships
  has_many :users, through: :memberships
  has_many :event_types
  has_many :people

  # TODO: Remove, for testing only
  # has_many :blah_users, through: :memberships, source: :user

  validates :name, presence: true


  scope :for_user, ->(user) { joins(:memberships).where(Membership.arel_table[:user_id].eq(user.id)) }

  def has_user?(user_or_user_id)
    user_id = user_or_user_id.kind_of?(User) ? user_or_user_id.id : user_or_user_id
    memberships.where(user_id: user_id).any?
  end
  
end
