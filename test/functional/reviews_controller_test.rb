# functional test 
#
# - make sure we test all attributes with CRUD for each model
# - by Jae Lee, June 8th 2012
#
# - upgraded to Rails 4 and ran a unit test on Nov 18th 2013
#
# run ruby -I test test/functional/reviews_controller_test.rb from eileensnotes folder

require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  # devise authentication methods are being used 
  include Devise::TestHelpers
  
  setup do
    @user = users(:one)
    @note = notes(:one)
    @review = reviews(:one)
  end

  test "should redirect to login" do
    get :index
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end
  
  test "should get index" do
    sign_in users(:one)
    get :index
    assert_response :success
  end

end
