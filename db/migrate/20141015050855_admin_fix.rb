class AdminFix < ActiveRecord::Migration
  def change
    remove_column :users, :admin, :boolean
    add_column :users, :admin, :boolean, default: false
  end
end
