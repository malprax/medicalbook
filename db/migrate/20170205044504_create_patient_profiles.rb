class CreatePatientProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :patient_profiles do |t|
      t.references :user, foreign_key: true
      t.string :services
      t.string :las_4_digits

      t.timestamps
    end
  end
end
