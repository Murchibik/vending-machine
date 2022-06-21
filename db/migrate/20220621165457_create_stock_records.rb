class CreateStockRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :stock_records do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
