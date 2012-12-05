class CreateAuthStatuses < ActiveRecord::Migration
  def change
    create_table :auth_statuses do |t|
      t.string :name
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end
  end
end
