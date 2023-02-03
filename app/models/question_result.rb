# frozen_string_literal: true

class QuestionResult < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :question
  belongs_to :study_session, optional: true
end
