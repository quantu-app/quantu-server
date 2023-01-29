# frozen_string_literal: true

class CreateStudySessions < ActiveRecord::Migration[7.0]
  def change
    create_table :study_sessions do |t|
      # attribs
      t.jsonb :data

      # relations
      t.references :user, null: false, foreign_key: true
      t.references :learnable_resource, null: false, foreign_key: true

      t.timestamps
    end
  end
end
