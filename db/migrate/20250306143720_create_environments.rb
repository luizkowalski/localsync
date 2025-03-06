class CreateEnvironments < ActiveRecord::Migration[8.0]
  def change
    create_table :environments do |t|
      t.string :contentful_id
      t.references :space, null: false, foreign_key: true

      t.timestamps
    end

    add_index :environments, :contentful_id, unique: true
  end
end
