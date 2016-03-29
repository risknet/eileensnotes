class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  # upgrade note: removed the following attr_accessible line
  # on 11/10/13, Jae Lee
  #attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  
  # any validation goes here
  validates :terms_of_service, :acceptance => {:accept => true}

  validates :name,
            :length => { :maximum => 20, :too_long => "is too long. Can we make it little short (~20 chars)?" }
   
  # user -> many notes(each note) -> many comments
  has_many :notes
  has_many :reviews
  has_many :ads

  #
  # static methods
  #
  
  def self.name_to_id(username)
    @user = find_by_email(username)
    if @user
      @user.id
    else
      nil
    end
  end
  
end
