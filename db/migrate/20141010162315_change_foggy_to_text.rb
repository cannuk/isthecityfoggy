class ChangeFoggyToText < ActiveRecord::Migration
  def change
    change_column :hours, :foggy, :string
  end
end
