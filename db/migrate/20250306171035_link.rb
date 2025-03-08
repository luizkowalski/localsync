class Link < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.references :entity, null: false, foreign_key: true
      t.references :linked_entity, null: false, foreign_key: { to_table: :entities }

      t.timestamps
    end

    add_index :links, [ :entity_id, :linked_entity_id ], unique: true
  end
end
