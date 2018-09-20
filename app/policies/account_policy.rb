class AccountPolicy < ApplicationPolicy
  def get_your_account?
    true
  end

  def update_account?
    true
  end

  def cancel_account?
    true
  end
end