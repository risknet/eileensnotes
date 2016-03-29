# unit test 
#
# - make sure we test all attributes with CRUD for each model
# - by Jae Lee, June 8th 2012
#

require 'test_helper'

class HelpControllerTest < ActionController::TestCase
  # devise authentication methods are being used 
  include Devise::TestHelpers
  
  test "should get index" do
    get :index
    assert_response :success
  end

end
