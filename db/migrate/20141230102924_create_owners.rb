class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
