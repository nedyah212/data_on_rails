class CreateCarPurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :car_purchases do |t|
      t.references :car, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.references :dealership, null: false, foreign_key: true
      t.date :purchase_date
      t.decimal :price_paid
      t.string :financing_type
      t.integer :kilometers_at_purchase
      t.string :condition

      t.timestamps
    end
  end
end
