# frozen_string_literal: true

class CreateLearnableResources < ActiveRecord::Migration[7.0]
  def change
    create_table :learnable_resources do |t|
      # relations
      t.bigint :learnable_id
      t.string :learnable_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :learnable_resources, %i[learnable_type learnable_id]
  end
end
