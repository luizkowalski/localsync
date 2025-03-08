class CreateEntities < ActiveRecord::Migration[8.0]
  def change
    create_table :entities do |t|
      t.string :type
      t.references :space, null: false, foreign_key: true
      t.references :environment, null: false, foreign_key: true
      t.string :contentful_id
      t.string :content_type_id
      t.bigint :published_version
      t.bigint :revision
      t.jsonb :fields

      t.timestamps
    end

    add_index :entities, [ :space_id, :environment_id, :contentful_id ], unique: true
  end
end
