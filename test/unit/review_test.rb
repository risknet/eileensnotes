# unit test 
#
# - make sure we test all attributes with CRUD for each model
# - by Jae Lee, June 8th 2012
#
# - upgraded to Rails 4 and ran a unit test on Nov 18th 2013
#
# run ruby -I test test/unit/review_test.rb from eileensnotes folder

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  # if "validates" is used in a model, try to create an object this way in Unit Test
  # create a new object Review
  def new_review(attributes = {})
    # get user object first from the fixture
    user = users(:one)
    note = notes(:one)
    # assign 
    review = Review.new(attributes)
    review.user_id = user.id
    review.note_id = note.id
    review.valid?
    review
  end
  
  # check if a new object is created ok
  test "this_should_create_review" do
    r = new_review
    assert r.valid?
  end
  
end
