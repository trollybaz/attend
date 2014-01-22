#### For testing only! ####

module Memberships
  class StandardSerializer < Serializer

    has_one :user, serializer: Users::StandardSerializer

  end
end
