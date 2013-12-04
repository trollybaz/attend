class Workspace < ActiveRecord::Base

  has_many :memberships
  has_many :users, through: :memberships
  has_many :event_types
  has_many :people
  
end
