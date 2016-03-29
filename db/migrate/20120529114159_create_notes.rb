class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :note
      t.text :content
      t.boolean :is_private
      t.references :user

      t.timestamps
    end
    add_index :notes, :user_id
  end
end
