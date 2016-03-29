module ReviewsHelper
  
  def get_marked_to_review(note_id, user_id)
    false
    if user_signed_in? and Review.find_by_note_id_and_user_id(note_id, user_id)
      true
    end
  end
  
  def count_marked_to_review(note_id)
    @temp_id = note_id
    # Review.count(:conditions => { :note_id => @temp_id })
    # upgraded to Rails 4, Nov 18th 2013
    # updated this count function as Model.count will be deprecated
    Review.where("note_id = ?", @temp_id).count
  end
  
end
