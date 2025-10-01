class AddManufacturerToFeature < ActiveRecord::Migration[8.0]
  def change
    add_column :features, :manufacturer_id, :string
  end
end
