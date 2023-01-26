# frozen_string_literal: true

class LearningSession < ApplicationRecord
  # relations
  belongs_to :user
  has_many :question_results, dependent: :destroy
  belongs_to :learnable, polymorphic: true
end
