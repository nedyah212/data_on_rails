class AddSalespersonToCarPurchases < ActiveRecord::Migration[8.0]
  def change
    add_reference :car_purchases, :salesperson, null: false, foreign_key: true
  end
end
