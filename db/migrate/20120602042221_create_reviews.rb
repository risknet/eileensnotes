class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :note
      t.references :user

      t.timestamps
    end
    add_index :reviews, :note_id
    add_index :reviews, :user_id
  end
end
