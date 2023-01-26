# frozen_string_literal: true

class LearningSession < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :learnable_resource
  has_one :learnable, through: :learnable_resource
end
