require 'test_helper'

class MarkdownControllerTest < ActionController::TestCase
  test "should get index" do
  	skip
    get :index
    assert_response :success
  end

end
