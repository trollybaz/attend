module Workspaces
  class ExtendedSerializer < StandardSerializer
    has_many   :users,        serializer: Users::StandardSerializer, embed_in_root: true, embed: :ids

    # for testing
    # has_many   :memberships,   serializer: Memberships::StandardSerializer
    # has_many   :blah_users,    serializer: Users::StandardSerializer, embed_in_root: true, root: :users
  end
end
