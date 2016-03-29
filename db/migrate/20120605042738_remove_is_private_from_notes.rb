class RemoveIsPrivateFromNotes < ActiveRecord::Migration
  def change
    remove_column :notes, :is_private
  end
end
