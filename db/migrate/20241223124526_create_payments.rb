class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.integer :unitary_amount
      t.string :method
      t.string :transaction_id
      t.date :transaction_date
      t.string :reason
      t.references :resident, null: false, foreign_key: true

      t.timestamps
    end
  end
end
