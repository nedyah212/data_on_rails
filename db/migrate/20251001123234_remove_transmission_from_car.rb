class RemoveTransmissionFromCar < ActiveRecord::Migration[8.0]
  def change
    remove_column :cars, :transmission, :string
  end
end
