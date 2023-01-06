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
  end

  context 'relations' do
    it { should have_many(:quizzes) }
    it { should have_many(:questions) }
  end
end
