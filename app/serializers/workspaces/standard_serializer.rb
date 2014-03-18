module Workspaces
  class StandardSerializer < Serializer
    attributes :id,
               :name

    # for testing
    # has_many   :memberships,   serializer: Memberships::StandardSerializer
  end
end
