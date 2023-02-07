# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Quiz, type: :model do
  context 'schema' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:uri).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }

    context 'validations' do
      subject { create(:quiz) }
      it { should validate_presence_of(:name) }
      it { should validate_length_of(:uri).is_at_least(3) }
      it { should allow_value('a-simple-uri').for(:uri) }
      it { should validate_uniqueness_of(:uri).scoped_to(:user_id).case_insensitive }
    end

    context 'relations' do
      it { should belong_to(:user) }
      it { should have_one(:learnable_resource).dependent(:destroy) }
      it { should have_many(:questions).dependent(:destroy) }
      it { should have_many(:study_sessions).dependent(:destroy) }
      it { should have_many(:question_results).dependent(:destroy) }
    end
  end
end
