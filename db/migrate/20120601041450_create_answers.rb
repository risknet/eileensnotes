class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :answer
      t.references :note
      t.references :user

      t.timestamps
    end
    add_index :answers, :note_id
    add_index :answers, :user_id
  end
end
