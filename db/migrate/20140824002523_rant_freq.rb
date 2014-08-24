class RantFreq < ActiveRecord::Migration
  def change
    remove_column :users, :post_frequency, :string
    add_column :users, :rant_frequency, :string
  end
end
