class ImagesFix < ActiveRecord::Migration
  def change
    remove_column :users, :image, :binary
    
    add_column :images, :filename, :string
    add_column :images, :content_type, :string
    add_column :images, :data, :binary
  end
end
