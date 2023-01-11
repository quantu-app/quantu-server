class Quiz < ApplicationRecord
  # validations
  include NameAndUri::UriFormat
  validates :uri, uniqueness: { scope: :user_id }
  validates :name, :uri, presence: true

  before_validation do
    self.uri = name.parameterize if name.present? && name_changed?
  end

  # relations
  belongs_to :user
  has_many :questions, dependent: :destroy
end
