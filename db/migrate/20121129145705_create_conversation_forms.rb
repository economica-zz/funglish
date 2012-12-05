class CreateConversationForms < ActiveRecord::Migration
  def change
    create_table :conversation_forms do |t|
      t.string :name
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end
  end
end
