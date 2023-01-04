# frozen_string_literal: true

class QuizPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user_owns_quiz?
  end

  def create?
    true
  end

  def update?
    user_owns_quiz?
  end

  def destroy?
    user_owns_quiz?
  end

  private
  def user_owns_quiz?
    user.quizzes.exists?(record.id)
  end
end
