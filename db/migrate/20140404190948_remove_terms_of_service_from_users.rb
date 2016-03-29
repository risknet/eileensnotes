class RemoveTermsOfServiceFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :accept_terms
  end
end
