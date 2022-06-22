class CreateUserDeposits < ActiveRecord::Migration[6.1]
  def change
    create_table :user_deposits do |t|
      t.integer :amount

      t.timestamps
    end
  end
end
