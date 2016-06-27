class CreateArmies < ActiveRecord::Migration
  def change
    create_table :armies do |t|
      t.string :name
      t.integer :infantry
      t.integer :archers
      t.integer :knights
      t.timestamps
    end
  end
end
