class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.references :user, foreign_key: true
      t.string :phone
      t.string :country
      t.string :city
      t.string :state
      t.string :zip
      t.string :address_1
      t.string :address_2
      t.boolean :main_address
      t.float :longitude
      t.float :latitude
      t.float :fetched_latitude
      t.float :fetched_longitude
      t.string :emergency_contact

      t.timestamps
    end
  end
end
