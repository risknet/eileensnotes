class AddTitleToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :title, :string
    add_column :notes, :question, :text
    remove_column :notes, :note
  end
end
