class CreatePeople < ActiveRecord::Migration[8.0]
  def change
    create_table :people do |t|
      t.references :city, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :age
      t.string :income_bracket
      t.string :phone

      t.timestamps
    end
  end
end
