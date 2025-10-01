class RemoveKilometersFromCars < ActiveRecord::Migration[8.0]
  def change
    remove_column :cars, :kilometers, :integer
  end
end
