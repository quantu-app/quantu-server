# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      # attribs
      t.string :email, unique: true, null: false
      t.string :username, unique: true, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
