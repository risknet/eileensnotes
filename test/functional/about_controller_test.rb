# unit test 
#
# - make sure we test all attributes with CRUD for each model
# - by Jae Lee, June 8th 2012
#
# - upgraded to Rails 4 and ran a unit test on Nov 18th 2013
#
# run ruby -I test test/functional/about_controller_test.rb from eileensnotes folder


require 'test_helper'

class AboutControllerTest < ActionController::TestCase
  # devise authentication methods are being used 
  include Devise::TestHelpers
  
  test "should get index" do
    get :index
    assert_response :success
  end

end
