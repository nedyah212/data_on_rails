class CreateCars < ActiveRecord::Migration[8.0]
  def change
    create_table :cars do |t|
      t.references :manufacturer, null: false, foreign_key: true
      t.string :make
      t.string :model
      t.integer :year
      t.decimal :base_price
      t.string :color
      t.string :engine_size
      t.string :transmission
      t.integer :kilometers

      t.timestamps
    end
  end
end
