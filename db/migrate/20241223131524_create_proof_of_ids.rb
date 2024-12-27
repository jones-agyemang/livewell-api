class CreateProofOfIds < ActiveRecord::Migration[8.0]
  def change
    create_table :proof_of_ids do |t|
      t.string :identifier_type
      t.string :identifier_value
      t.references :resident, null: false, foreign_key: true

      t.timestamps
    end
  end
end
