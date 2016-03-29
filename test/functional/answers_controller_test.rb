# functional test 
#
# - make sure we test all attributes with CRUD for each model
# - by Jae Lee, June 8th 2012
#
# - upgraded to Rails 4 and ran a unit test on Nov 18th 2013
#
# run ruby -I test test/functional/answers_controller_test.rb from eileensnotes folder

require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  # devise authentication methods are being used 
  include Devise::TestHelpers
  
  setup do
    @note = notes(:one)
    @answer = answers(:one)
  end

  # revisit this test procedure!!!!
  test "should redirect to login" do
    #get :new
    #assert_response :redirect
    #assert_redirected_to new_user_session_path
    
    #get :destroy, :id => @note.to_param
    #assert_response :redirect
    #assert_redirected_to new_user_session_path
    
    #get :edit, :id => @note.to_param
    #assert_response :redirect
    #assert_redirected_to new_user_session_path
  end
  
  test "should get index" do
    get :index, note_id: @note.id
    assert_response :success
    assert_not_nil assigns(:answers)
  end

  test "should get new" do
    sign_in users(:one)
    get :new, note_id: @note.id
    assert_response :success
  end

  test "should create answer" do
    sign_in users(:one)
    assert_difference('Answer.count') do
      post :create, note_id: @note.id, answer: { answer: @answer.answer }
    end
    assert_redirected_to note_answers_url
    # check the flash notice message
    assert_match 'Your answer was posted. Thank you!', flash[:notice] 
  end

  test "should get edit" do
    sign_in users(:one)
    get :edit, note_id: @note.id, id: @answer
    assert_response :success
  end

  test "should update answer" do
    sign_in users(:one)
    patch :update, note_id: @note.id, id: @answer, answer: { answer: @answer.answer }
    assert_redirected_to note_answers_url
    # check the flash notice message
    assert_match 'Your answer was successfully updated. Thank you!', flash[:notice] 
  end

  test "should update only allowed columns" do
    sign_in users(:one)
    patch :update, note_id: @note.id, id: @answer, answer: { answer: @answer.answer, user_id: 999 }
    # confirmed column should be unchanged!!!!
    assert_not_equal 999, Answer.find(answers(:one).id).user_id
  end  

  test "should destroy answer" do
    sign_in users(:one)
    assert_difference('Answer.count', -1) do
      delete :destroy, note_id: @note.id, id: @answer
    end
    assert_redirected_to note_answers_url
    # check the flash notice message
    assert_match 'Successfully deleted your answer.', flash[:notice] 
  end
end
