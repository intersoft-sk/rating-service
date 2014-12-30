class ModifyRating < ActiveRecord::Migration
  def up
    drop_table :ratings
    
    create_table :ratings do |t|
      t.uuid :event_id
      t.uuid :entity_id
      t.string :username
      t.text :comment
      t.integer :rating
      t.references :owner
      # Let Rails automatically keep track of when 
      # localIdentities are added or modified:
      t.timestamps null: false
    end
  end

  def down
#   drop_table :ratings
  end
end
