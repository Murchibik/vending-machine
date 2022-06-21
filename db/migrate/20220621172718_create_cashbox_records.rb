class CreateCashboxRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :cashbox_records do |t|
      t.integer :transaction_direction, default: 0
      t.integer :amount, default: 0
      t.integer :product_id
      t.string :comment

      t.timestamps
    end
  end
end
