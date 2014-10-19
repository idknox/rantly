class Timestamps < ActiveRecord::Migration
  def change
    add_column :rants, :created_at, :datetime
    add_column :rants, :updated_at, :datetime
  end
end
