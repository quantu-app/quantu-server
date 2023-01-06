# frozen_string_literal: true

class QuestionPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user_owns_question?
  end

  def create?
    true
  end

  def update?
    user_owns_question?
  end

  def move?
    user_owns_question?
  end

  def destroy?
    user_owns_question?
  end

  private
  def user_owns_question?
    user.questions.exists?(record.id)
  end
end
