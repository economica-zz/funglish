class CreateTermsOfServices < ActiveRecord::Migration
  def change
    create_table :terms_of_services do |t|
      t.text :content
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end

    add_index :terms_of_services, :deleted, name: "idx_terms_of_services_01"
  end
end
