class AddIsPrivateToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :is_private, :boolean, :default => false
  end
end
