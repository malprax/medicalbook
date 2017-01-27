class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at


      t.timestamps null: false

      t.string :first_name
      t.string :last_name
      t.string :type
      t.string :company
      t.string :date_of_birth
      t.boolean :active, default: true, null: false
      t.float :longitude
      t.float :latitude
      t.string :payment_methods, array: true
      t.string :institution_name
      t.string :institution_number
      t.string :institution_address
      t.string :bank_account_number
      t.string :paypal_email
      t.boolean :is_superadmin, default: false
      t.string :provider
      t.string :uid
      t.boolean :wizard_completed, default: false
      t.string :wizard_step, default: "welcome"
      t.string :goverment_issued_id_type
      t.text :goverment_issued_id_data # photo

    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end
end
