require 'rails_helper'

RSpec.describe QuestionResult, type: :model do
  context 'schema' do
    it { should have_db_column(:data).of_type(:jsonb) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }

    context 'validations' do
      # noop
    end

    context 'relations' do
      it { should belong_to(:user) }
      it { should belong_to(:question) }
      it { should belong_to(:learning_session) }
    end
  end
end