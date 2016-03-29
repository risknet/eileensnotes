require 'test_helper'

class CloudsControllerTest < ActionController::TestCase
  # devise authentication methods are being used 
  include Devise::TestHelpers

  test "should get index" do
    get :index
    assert_response :success
  end

end
