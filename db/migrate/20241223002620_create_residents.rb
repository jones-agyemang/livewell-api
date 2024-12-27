class CreateResidents < ActiveRecord::Migration[8.0]
  def change
    create_table :residents do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :date_of_birth
      t.string :gender

      t.timestamps
    end
  end
end
