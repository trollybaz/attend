class WorkspacePolicy
  attr_reader :user, :workspace

  self::Scope = Struct.new(:user, :scope) do
    def resolve
      scope.for_user(user)
    end
  end

  def initialize(user, workspace)
    @user = user
    @workspace = workspace
  end

  def create?
    !workspace.persisted?
  end

  # show, update
  def show?
    workspace.has_user?(user)
  end

  def destroy?
    # TODO: Add owner_id to workspace, which should default to the creator
    # Only owners should be able to destroy the workspace
    false
  end
  alias_method :update?, :destroy?

end
