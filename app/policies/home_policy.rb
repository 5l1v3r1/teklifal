class HomePolicy < ApplicationPolicy

  def index?
    true
  end

  def pro?
    true
  end
end