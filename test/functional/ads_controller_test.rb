# functional test 
#
# - make sure we test all attributes with CRUD for each model
# - by Jae Lee, June 8th 2012
#
# - upgraded to Rails 4 and ran a unit test on Nov 18th 2013
#
# run ruby -I test test/functional/ads_controller_test.rb from eileensnotes folder


require 'test_helper'

class AdsControllerTest < ActionController::TestCase
  # devise authentication methods are being used 
  include Devise::TestHelpers
  
  setup do
    @ad = ads(:one)
  end
  
  test "should redirect to login" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
    
    get :destroy, :id => @ad.to_param
    assert_response :redirect
    assert_redirected_to new_user_session_path
    
    get :edit, :id => @ad.to_param
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ads)
  end

  test "should get new" do
    sign_in users(:one)
    get :new
    assert_response :success
  end

  test "should create ad" do
    sign_in users(:one)
    assert_difference('Ad.count') do
      post :create, ad: { ad_title: @ad.ad_title, ad_content: @ad.ad_content }
    end
    assert_redirected_to ads_url
    # check the flash notice message
    #assert_match 'Your Ad will be appeard once it gets comfirmed. Thank you!', flash[:notice] 
    assert_match 'Your Advertisement has been successfully posted. Thank you!', flash[:notice]
  end
  
  test "should get edit" do
    sign_in users(:one)
    get :edit, id: @ad
    assert_response :success
  end

  test "should update ad" do
    sign_in users(:one)
    patch :update, id: @ad, ad: { ad_title: @ad.ad_title, ad_content: @ad.ad_content }
    assert_redirected_to ads_url
    # check the flash notice message
    #assert_match 'Your Ad will be appeard once it gets comfirmed.', flash[:notice] 
    assert_match 'Your Advertisement has been successfully updated. Thank you!', flash[:notice]
  end

  test "should update only allowed columns" do
    sign_in users(:one)
    patch :update, id: @ad, ad: { ad_title: @ad.ad_title, ad_content: @ad.ad_content, confirmed: true }
    # confirmed column should be unchanged!!!!
    assert_equal false, Ad.find(ads(:one).id).confirmed
  end    

  test "should destroy answer" do
    sign_in users(:one)
    assert_difference('Ad.count', -1) do
      delete :destroy, id: @ad
    end
    assert_redirected_to ads_url
    # check the flash notice message
    assert_match 'Successfully deleted yours.', flash[:notice] 
  end

end
