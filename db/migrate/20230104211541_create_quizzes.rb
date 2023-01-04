# frozen_string_literal: true

class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :uri, null: false
      t.integer :position

      t.timestamps
    end

    add_index :quizzes, %i[user_id name], unique: true
  end
end
