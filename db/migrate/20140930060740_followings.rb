class Followings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :follower_id
      t.integer :followee_id
    end
    add_index :followings, :follower_id
    add_index :followings, :followee_id
    add_index :followings, [:follower_id, :followee_id], unique: true
  end
end
