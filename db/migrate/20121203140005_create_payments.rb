class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user
      t.references :lesson
      t.references :payment_method
      t.integer :amount
      t.timestamp :pay_timestamp
      t.timestamp :expiration_timestamp
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end

    add_index :payments, [:user_id, :lesson_id, :deleted], name: "idx_payments_01"
    add_index :payments, [:lesson_id, :user_id, :deleted], name: "idx_payments_02"
  end
end
