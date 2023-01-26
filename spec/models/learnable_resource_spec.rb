# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LearnableResource, type: :model do
  context 'schema' do
    it { should have_db_column(:learnable_id).of_type(:integer) }
    it { should have_db_column(:learnable_type).of_type(:string) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }

    context 'validations' do
      # noop
    end

    context 'relations' do
      it { should belong_to(:user) }
      it { should belong_to(:learnable) }
      it { should have_many(:questions) }
      it { should have_many(:question_results).through(:questions) }
    end
  end
end
