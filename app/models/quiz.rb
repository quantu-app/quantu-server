class Quiz < ApplicationRecord
  # validations
  include NameAndUri::NameAndUriPresence
  include NameAndUri::UriFormat
  include NameAndUri::SetUriFromName
  validates :uri, uniqueness: { scope: :user_id }

  # relations
  belongs_to :user
  has_many :questions, dependent: :destroy
end
