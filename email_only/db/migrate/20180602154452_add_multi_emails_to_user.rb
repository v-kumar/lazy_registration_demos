class AddMultiEmailsToUser < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer :user_id
      t.string :email
      t.boolean :primary, default: false

      ## Confirmable
      t.string :unconfirmed_email
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
    end

    [:email, :unconfirmed_email, :confirmation_token, :confirmed_at, :confirmation_sent_at].each do |email_field|
      remove_column :users, email_field
    end
  end
end
