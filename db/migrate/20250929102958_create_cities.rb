class CreateCities < ActiveRecord::Migration[8.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :province
      t.string :country
      t.integer :population

      t.timestamps
    end
  end
end
