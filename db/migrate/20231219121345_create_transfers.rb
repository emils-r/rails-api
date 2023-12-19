class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.integer :wallet_from, null: false
      t.integer :wallet_to, null: false
      t.decimal :amount, null: false
      t.string :currency, null: false
      t.decimal :exchange_rate
      t.boolean :is_done, :default => false

      t.timestamps
    end
  end
end
