class AddTrimToCar < ActiveRecord::Migration[8.0]
  def change
    add_column :cars, :trim, :string
  end
end
