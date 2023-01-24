# frozen_string_literal: true

class CreateLearningSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :learning_sessions do |t|
      # attribs
      t.jsonb :data

      # relations
      t.bigint :learnable_id
      t.string :learnable_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :learning_sessions, %i[learnable_type learnable_id]
  end
end
