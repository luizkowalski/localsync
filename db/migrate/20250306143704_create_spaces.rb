class CreateSpaces < ActiveRecord::Migration[8.0]
  def change
    create_table :spaces do |t|
      t.string :contentful_id
      t.datetime :last_synced_at
      t.string :access_token
      t.string :next_sync_token

      t.timestamps
    end

    add_index :spaces, :contentful_id, unique: true
  end
end
