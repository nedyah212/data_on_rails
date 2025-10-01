class AddManufacturerForeignKeyToFeatures < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :features, :manufacturers, column: :manufacturer_id
  end
end
