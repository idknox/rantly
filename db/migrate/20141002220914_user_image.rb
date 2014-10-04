class UserImage < ActiveRecord::Migration
  def change
    add_column :users, :image, :binary
  end
end
