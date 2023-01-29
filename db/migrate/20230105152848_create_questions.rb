# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      # attribs
      t.string :name, null: false
      t.string :uri, null: false
      t.string :question_type, null: false
      t.integer :item_order
      t.jsonb :data

      # relations
      t.references :user, null: false, foreign_key: true
      t.references :learnable_resource, null: false, foreign_key: true

      t.timestamps
    end

    add_index :questions, %i[user_id uri], unique: true
  end
end
