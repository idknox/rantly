class FixConfirm < ActiveRecord::Migration
  def change
    remove_column :users, :confirmed, :boolean
    add_column :users, :confirmed, :boolean, default: false
  end
end
