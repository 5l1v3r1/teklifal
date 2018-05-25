class DashboardPolicy < ApplicationPolicy

  def show?
    signed_user.moderator? or signed_user.superadmin?
  end

end