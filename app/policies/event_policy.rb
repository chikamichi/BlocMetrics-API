class EventPolicy < ApplicationPolicy
  def create?
    user.present? && app.user == current_user
  end
end
