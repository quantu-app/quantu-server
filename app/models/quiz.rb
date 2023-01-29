# frozen_string_literal: true

class Quiz < ApplicationRecord
  # validations
  include NameAndUri::UriFormat
  validates :uri, uniqueness: { scope: :user_id }
  validates :name, :uri, presence: true

  before_validation do
    self.uri = name.parameterize if name.present? && name_changed?
    self.learnable_resource = build_learnable_resource(user:) unless learnable_resource
  end

  # relations
  belongs_to :user
  has_one :learnable_resource, as: :learnable, dependent: :destroy
  has_many :questions, through: :learnable_resource, dependent: :destroy
  has_many :study_sessions, through: :learnable_resource, source: :learnable, source_type: 'Quiz', dependent: :destroy
end
