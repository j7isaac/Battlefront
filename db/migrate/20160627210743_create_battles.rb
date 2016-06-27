class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.integer :army_a
      t.integer :army_b
      t.timestamps
    end
  end
end
