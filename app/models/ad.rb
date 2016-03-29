class Ad < ActiveRecord::Base
  # user -> many ADs
  belongs_to :user
  
  # text search in PostgreSQL
  include PgSearch
  pg_search_scope :search_by_title_content, :against => [:ad_title, :ad_content]
  
  # Alias for acts_as_taggable_on :tags
  acts_as_taggable
  scope :by_date, -> { order("updated_at DESC") }
  
  # any validation goes here
  validates :ad_title,
            :presence => true,
            :length => { :maximum => 100, :too_long => "is too long. Can we make it little short (~100 chars)?" }
    
  validates :ad_content,
            :presence => true,
            :length => { :maximum => 2000, :too_long => 'is too long. Can we make it little short (~2,000 chars)' }

  validates :tag_list,
            :length => { :maximum => 40, :too_long => "is too long for keyword(s). Can we make it little short (~40 chars)?" }
            
  self.per_page = 20
  
  
  #
  # static methods
  #
  
  def self.find_ad(ad_id)
    where("id = ?", ad_id).first
  end
  
  def self.find_all_ads(current_page)
    #where("confirmed = ?", true).paginate(:page => current_page).order("updated_at DESC")
    paginate(:page => current_page).order("updated_at DESC")
  end
  
  # run a full-text-search
  def self.full_text_search(query, current_page)
    search_by_title_content(query).paginate(:page => current_page).order("updated_at DESC")
  end
  
  # get all QAs for a given tag
  def self.find_by_tag(tag_name, current_page)
    tagged_with(tag_name).by_date.paginate(:page => current_page)
  end
  
end
