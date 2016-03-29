class Answer < ActiveRecord::Base
  # any validation goes here
  validates :answer,
            :presence => true,
            :length => { :maximum => 3000, :too_long => "is too long for an answer. Can we make it little short (~3000 chars)?" }
            
  # user -> many notes(each note) -> many comments
  #
  # answer is always belonging to a parent note
  # make sure we count total number of counts in a parent note
  belongs_to :note, :counter_cache => true
  belongs_to :user
  
  #
  # static methods
  #
  
  # get all public answers 
  def self.find_all_public_answers
    where("is_private != true").order("updated_at DESC")
  end

  # get all comments
  def self.find_all_answers
    order("updated_at DESC")
  end

  # get all public answers + user's answers
  def self.find_all_public_user_answers(user_id)
    where("is_private != true or user_id = ?", user_id).order("updated_at DESC")
  end
  
end
