# frozen_string_literal: true

class LearnableResource < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :learnable, polymorphic: true
  has_many :questions, dependent: :destroy
  has_many :question_results, through: :questions
end
