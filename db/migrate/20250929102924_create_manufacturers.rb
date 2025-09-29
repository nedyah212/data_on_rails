class CreateManufacturers < ActiveRecord::Migration[8.0]
  def change
    create_table :manufacturers do |t|
      t.string :name
      t.string :country
      t.integer :founded_year

      t.timestamps
    end
  end
end
