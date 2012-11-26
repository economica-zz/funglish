class CreateSexes < ActiveRecord::Migration
  def change
    create_table :sexes do |t|
      t.string :name
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end
  end
end
