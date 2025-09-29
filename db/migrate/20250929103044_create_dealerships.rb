class CreateDealerships < ActiveRecord::Migration[8.0]
  def change
    create_table :dealerships do |t|
      t.references :city, null: false, foreign_key: true
      t.string :name
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
