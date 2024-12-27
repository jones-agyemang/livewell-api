class CreateContactDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :contact_details do |t|
      t.string :email
      t.string :mobile_number
      t.references :resident, null: false, foreign_key: true

      t.timestamps
    end
  end
end
