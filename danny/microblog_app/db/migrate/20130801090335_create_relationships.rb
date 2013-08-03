class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :fan_id
      t.integer :followed_id

      t.timestamps
    end

    add_index :relationships, :fan_id
    add_index :relationships, :followed_id
    add_index :relationships, [:fan_id, :followed_id], unique: true
  end
end
