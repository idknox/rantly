class Freq < ActiveRecord::Migration
  def change
    remove_column :users, :frequency, :string
    add_column :users, :post_frequency, :string
  end
end
