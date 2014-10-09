class Comments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :rant_id
      t.text :body
    end
  end
end
