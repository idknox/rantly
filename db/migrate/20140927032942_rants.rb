class Rants < ActiveRecord::Migration
  def change
    create_table :rants do |t|
      t.string :subject
      t.text :body
      t.integer :user_id
    end
  end
end
