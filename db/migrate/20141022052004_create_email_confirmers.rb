class CreateEmailConfirmers < ActiveRecord::Migration
  def change
    create_table :email_confirmers do |t|
      t.integer :user_id
      t.string :confirmation_token

      t.timestamps
    end
  end
end
