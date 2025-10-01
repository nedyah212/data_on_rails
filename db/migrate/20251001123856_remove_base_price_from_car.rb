class RemoveBasePriceFromCar < ActiveRecord::Migration[8.0]
  def change
    remove_column :cars, :base_price, :decimal
  end
end
