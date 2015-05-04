class EventPolicy < ApplicationPolicy
  def create?
    user.present? && record.app.user == user
  end
end
