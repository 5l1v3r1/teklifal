class DashboardPolicy < ApplicationPolicy

  def show?
    signed_user.try :manager?
  end

end