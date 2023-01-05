# frozen_string_literal: true

module NameAndUri
  module NameAndUriPresence
    extend ActiveSupport::Concern

    included do
      validates :name, :uri, presence: true
    end
  end

  module UriFormat
    extend ActiveSupport::Concern

    included do
      validates :uri, format: {
        with: /\A[a-z0-9-]+\z/,
        message: I18n.t('errors.uri_format_error')
      }
      validates :uri, length: { minimum: 3 }
    end
  end

  module SetUriFromName
    extend ActiveSupport::Concern

    included do
      before_validation :set_uri_from_name, on: :update

      def set_uri_from_name
        self.uri = name.parameterize if name.present?
      end
    end
  end

  module GenerateRandomNameAndUri
    extend ActiveSupport::Concern

    included do
      before_validation :generate_name_and_uri, on: :create

      def generate_name_and_uri
        
        # set uri from name is uri is not present and name has been given
        if self.name.present?
          self.uri = self.name.parameterize
          return
        end

        # we have no name or uri so let's generate some random name/uri
        new_uri = loop do
          random_token = SecureRandom.urlsafe_base64(nil, false).gsub(/[\-=\+\/]/, '').downcase
          break random_token unless self.class.exists?(uri: random_token)
        end

        self.name = self.uri = new_uri
      end
    end
  end
end
