class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.references :client, null: false, foreign_key: true
      t.string :currency, null: false
      t.decimal :balance, :default => 0.00
      t.boolean :is_deleted, :default => 0

      t.timestamps
    end
  end
end
