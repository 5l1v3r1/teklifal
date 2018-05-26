class DashboardPolicy < ApplicationPolicy

  def show?
    signed_user.manager?
  end

end