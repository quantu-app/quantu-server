class Quiz < ApplicationRecord
  # validations
  include NameAndUri::NameAndUriPresence
  include NameAndUri::UriFormat
  include NameAndUri::SetUriFromName
  validates :uri, uniqueness: true

  # relations
  belongs_to :user
end
