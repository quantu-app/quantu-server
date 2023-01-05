class Question < ApplicationRecord
  include NameAndUri::NameAndUriPresence
  include NameAndUri::UriFormat
  include NameAndUri::GenerateRandomNameAndUri
  include NameAndUri::SetUriFromName
  validates :uri, uniqueness: { scope: :user_id }

  # relations
  belongs_to :user
  belongs_to :quiz
end
