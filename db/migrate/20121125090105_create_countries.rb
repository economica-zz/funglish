class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end
  end
end
