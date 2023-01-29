# frozen_string_literal: true

class StudySessionPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user_owns_study_session?
  end

  def create?
    true
  end

  def update?
    user_owns_study_session?
  end

  def destroy?
    user_owns_study_session?
  end

  private

  def user_owns_study_session?
    user.study_sessions.exists?(record.id)
  end
end
