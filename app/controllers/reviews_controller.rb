# eileensnotes.com - online Q&A site for everyone who enjoys learning
#
# *** Ideas are worthless unless they are executes
# *** Focus on the things that matter
#
# Last updated on 4/3/2014
# - reviewed all lines for upgrading to Zurb Foundation#
#
#
#
class ReviewsController < ApplicationController
  # make sure user has been authorized
  before_action :authenticate_user!
  
  # GET /notes
  def index
    page = params[:page] || 1
    # this will get current user's marked reviews
    @notes = Note.find_marked_by_user(current_user.id, page)
    # calling index.html.erb
  end
  
  #
  # all other methods 
  #
  
  def mark_to_review
    if !check_if_marked(params[:id], current_user.id)
      @review = Review.new
      @review.note_id = params[:id]
      @review.user_id = current_user.id
      if @review.save
        redirect_to notes_url, :notice => "The question has been marked for review."
      else
        render :action => "new"
      end
    else
      redirect_to notes_url, :notice => "The question has been already marked for review."
    end
  end
  
  # 
  def unmark_review
    @review = Review.find_by_note_id_and_user_id(params[:id], current_user.id)
    if @review.destroy
      redirect_to notes_url, :notice => "The question has been unmarked."
    end
  end
  
  
  #
  # private
  #
  private
  
  def check_if_marked(note_id, user_id)
    false
    if Review.find_by_note_id_and_user_id(note_id, user_id)
      true
    end
  end
  
  
  def review_params
    params.require(:review).permit(:title, :body) 
  end
  
end
