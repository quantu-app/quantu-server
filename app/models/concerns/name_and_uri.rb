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
      before_validation :set_uri_from_name

      def set_uri_from_name
        self.uri = name.parameterize if name.present?
      end
    end
  end
end
