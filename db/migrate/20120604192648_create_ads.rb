class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :ad_title
      t.text :ad_content
      t.references :user
      t.boolean :confirmed, :default => false

      t.timestamps
    end
    add_index :ads, :user_id
  end
end
