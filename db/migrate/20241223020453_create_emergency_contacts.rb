class CreateEmergencyContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :emergency_contacts do |t|
      t.string :name
      t.string :relationship
      t.string :mobile_number
      t.string :email
      t.references :resident, null: false, foreign_key: true

      t.timestamps
    end
  end
end
