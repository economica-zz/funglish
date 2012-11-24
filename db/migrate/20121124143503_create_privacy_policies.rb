class CreatePrivacyPolicies < ActiveRecord::Migration
  def change
    create_table :privacy_policies do |t|
      t.text :content
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end

    add_index :privacy_policies, :deleted, name: "idx_privacy_policies_01"
  end
end
