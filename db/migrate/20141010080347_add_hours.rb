class AddHours < ActiveRecord::Migration
  def up
    create_table :hours do |t|
      t.integer :hour
      t.boolean :foggy
      t.timestamps
    end

  end

  def down
  end
end
