class Note < ActiveRecord::Base
  # text search in PostgreSQL
  include PgSearch
  pg_search_scope :search_by_question, :against => [:question]
  
  # Alias for acts_as_taggable_on :tags
  acts_as_taggable

  scope :by_date, -> { order("updated_at DESC") }
  
  # any validation goes here
  # title column is no longer used
  #validates :title,
  #          :presence => true,
  #          :length => { :maximum => 200, :too_long => "is too long. Can we make it little short (~200 chars)?" }
  # 
  validates :question,
            :presence => true,
            :length => { :maximum => 2000, :too_long => "is too long for a question. Can we make it little short (~2000 chars)?" }
  
  validates :tag_list,
            :length => { :maximum => 40, :too_long => "is too long for keyword(s). Can we make it little short (~40 chars)?" }
     
            
  self.per_page = 10
  
  
  # user -> many notes(each note) -> many comments
  #
  belongs_to :user
  # make sure we delete all answers attached to this note?
  # NO, if answer is attached to it then we won't let the author delete the question
  # but, if the question has been bookmarked, then we will delete thi in reviews table
  has_many   :answers  #, :dependent => :destroy
  has_many   :reviews,  :dependent => :destroy
  
  #
  # static methods
  #
  
  def self.find_note(note_id)
    where("id = ?", note_id).first
  end

  def self.find_all_notes(current_page)
    paginate(:page => current_page).order("updated_at DESC")
  end
  
  # get all UNANSWERED questions
  def self.find_all_unanswered(current_page)
    where("answers_count = 0").paginate(:page => current_page).order("updated_at DESC")
  end
  
  # get all QAs by user
  def self.find_by_user(user_id, current_page)
    where("user_id = ?", user_id).paginate(:page => current_page).order("updated_at DESC")
  end
  
  # get all QAs that a given user marked for review
  def self.find_marked_by_user(user_id, current_page)
    joins("INNER JOIN reviews ON reviews.note_id = notes.id and reviews.user_id = #{user_id}").paginate(:page => current_page).order("updated_at DESC")
    #Client.joins('LEFT OUTER JOIN addresses ON addresses.client_id = clients.id')
  end
  
  # get all notes for a given "private"
  def self.find_private(current_page)
    where("is_private = ?", true).paginate(:page => current_page).order("updated_at DESC")
  end
  
  # run a full-text-search
  def self.full_text_search(query, current_page)
    #where("group_id = ? and note @@ ?", group_id, query).order("updated_at DESC")
    search_by_question(query).paginate(:page => current_page).order("updated_at DESC")
  end
  
  # get all QAs for a given tag
  def self.find_by_tag(tag_name, current_page)
    tagged_with(tag_name).by_date.paginate(:page => current_page)
  end
  
  
end
