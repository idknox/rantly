class Favorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.belongs_to :user
      t.belongs_to :rant
    end
  end
end
