# eileensnotes.com - online Q&A site for everyone who enjoys learning
#
# *** Ideas are worthless unless they are executes
# *** Focus on the things that matter
#
# Programmed by Jae Lee
#
# Last updated on 4/3/2014
# - reviewed all lines for upgrading to Zurb Foundation
#

class CloudsController < ApplicationController
	# make sure user has been authorized
  before_action :authenticate_user!, :except => [:index]

  def index
  end

  #
  # all other functions that are not CRUD
  #

end
