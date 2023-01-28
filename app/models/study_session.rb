# frozen_string_literal: true

class StudySession < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :learnable_resource
end
