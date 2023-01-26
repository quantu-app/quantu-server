# frozen_string_literal: true

class CreateQuestionResults < ActiveRecord::Migration[7.0]
  def change
    create_table :question_results do |t|
      # attribs
      t.jsonb :data

      # relations
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :learning_session, null: true, foreign_key: true

      t.timestamps
    end
  end
end
