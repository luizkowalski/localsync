class Link < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.references :entry, null: false, foreign_key: true
      t.references :linked_entry, null: false, foreign_key: { to_table: :entries }

      t.timestamps
    end

    add_index :links, [ :entry_id, :linked_entry_id ], unique: true
  end
end
