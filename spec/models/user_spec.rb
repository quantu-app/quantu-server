# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'schema' do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:username).of_type(:string) }
    it { should have_db_column(:password_digest).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'validations' do
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(6).on(:create) }
    it { should validate_confirmation_of(:password) }
    it { should validate_length_of(:username).is_at_least(3) }
    it {
      # we have to have a valid user in the database, this is what build(:user) does.
      user = build(:user)
      expect(user).to validate_uniqueness_of(:email)
      expect(user).to validate_uniqueness_of(:username)
    }
  end

  context 'relations' do
    it { should have_many(:quizzes).dependent(:destroy) }
    it { should have_many(:questions).dependent(:destroy) }
    it { should have_many(:study_sessions).dependent(:destroy) }
  end
end
