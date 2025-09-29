class CreateFeatures < ActiveRecord::Migration[8.0]
  def change
    create_table :features do |t|
      t.string :name
      t.text :description
      t.string :category
      t.decimal :base_cost

      t.timestamps
    end
  end
end
