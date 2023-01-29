# frozen_string_literal: true

class Question < ApplicationRecord
  self.inheritance_column = nil

  # validations
  include NameAndUri::UriFormat
  include NameAndUri::GenerateRandomNameAndUri
  validates :uri, uniqueness: { scope: :user_id }
  validates :name, :uri, presence: true
  before_validation proc {
    self.uri = name.parameterize if name.present? && name_changed?
  }, on: :update

  # plugins
  include RankedModel
  ranks :item_order

  # relations
  belongs_to :user
  belongs_to :learnable_resource
  has_one :quiz, through: :learnable_resource, source: :learnable, source_type: 'Quiz'
  has_many :question_results, dependent: :destroy
end
