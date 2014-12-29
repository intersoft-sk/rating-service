class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.uuid :event_id
      t.uuid :meat_id
      t.string :username
      t.text :comment
      t.integer :rating

      t.timestamps null: false
    end
  end
end
