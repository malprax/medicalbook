class CreateTherapists < ActiveRecord::Migration[5.0]
  def change
    create_table :therapists do |t|

      t.timestamps
    end
  end
end
