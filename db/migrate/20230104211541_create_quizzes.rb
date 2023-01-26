# frozen_string_literal: true

class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.string :name, null: false
      t.string :uri, null: false

      # relations
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :quizzes, %i[user_id uri], unique: true
  end
end
