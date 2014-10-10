class CreateHours < ActiveRecord::Migration
  def change
    add_index :hours, :hour, :unique => true
  end
end
