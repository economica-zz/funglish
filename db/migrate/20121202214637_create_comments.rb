class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :lesson
      t.references :user
      t.text :content
      t.boolean :is_parent, null: false, default: false
      t.references :parent_comment
      t.boolean :deleted, null: false, default: false
      t.timestamps
    end

    add_index :comments, [:lesson_id, :deleted], name: "idx_comments_01"
    add_index :comments, [:parent_comment_id, :deleted], name: "idx_comments_02"
  end
end
