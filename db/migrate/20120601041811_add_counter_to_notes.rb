class AddCounterToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :answers_count, :integer, :default => 0
  end
end
