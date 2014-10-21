class FixDisable < ActiveRecord::Migration
  def change
    remove_column :users, :disabled, :boolean
    add_column :users, :disabled, :boolean, default: false
  end
end
