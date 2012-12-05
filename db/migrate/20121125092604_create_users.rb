class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :last_name_kana
      t.string :first_name_kana
      t.references :sex
      t.date :birthday
      t.references :nationality_country
      t.references :occupation
      t.references :location_country
      t.references :location_prefecture
      t.string :location_city
      t.references :time_zone
      t.string :email_address
      t.string :telephone_number
      t.string :skype_name
      t.string :google_account
      t.text :self_introduction
      t.string :facebook_id
      t.string :facebook_link
      t.references :terms_of_service
      t.references :privacy_policy
      t.boolean :is_email_address_confirmed, null: false, default: false
      t.string :email_address_confirmation_code
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end

    add_index :users, [:email_address, :deleted], name: "idx_users_01"
    add_index :users, [:facebook_id, :deleted], name: "idx_users_02"
  end
end
