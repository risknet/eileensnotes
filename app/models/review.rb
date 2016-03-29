class Review < ActiveRecord::Base
  # user -> many notes(each note) -> many comments
  #
  belongs_to :note
  belongs_to :user
  
  
  #
  # static methods
  #
  
  def self.find_all_reviews(current_page, user_id)
    where("user_id = ?", user_id).paginate(:page => current_page).order("updated_at DESC")
  end
  
end
