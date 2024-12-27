class CreateStayDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :stay_details do |t|
      t.date :move_in_date
      t.string :duration_of_stay
      t.text :special_requirements
      t.references :resident, null: false, foreign_key: true

      t.timestamps
    end
  end
end
