class ApplicationPolicy
  attr_reader :signed_user, :record

  def initialize(signed_user, record)
    @signed_user = signed_user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(signed_user, record.class)
  end

  class Scope
    attr_reader :signed_user, :scope

    def initialize(signed_user, scope)
      @signed_user = signed_user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
