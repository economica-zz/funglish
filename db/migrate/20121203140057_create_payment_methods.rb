class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end
  end
end
