# frozen_string_literal: true

class QuestionResultPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user_owns_question_result?
  end

  def create?
    true
  end

  def destroy?
    user_owns_question_result?
  end

  def destroy_all?
    true # TODO: figure out how to scope policies
  end

  private

  def user_owns_question_result?
    question_result.user_id == user.id
  end
end
