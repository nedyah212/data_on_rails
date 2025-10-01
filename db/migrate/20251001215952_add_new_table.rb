class AddNewTable < ActiveRecord::Migration[8.0]
  def change
    create_table :salespeople do |t|
      t.references :dealership_id, null: false, foreign_key: true
      t.references :person_id, null: false, foreign_key: true
      t.string :position, null: false
    end
  end
end
