# functional test 
#
# - make sure we test all attributes with CRUD for each model
# - by Jae Lee, June 8th 2012
#
# - upgraded to Rails 4 and ran a unit test on Nov 18th 2013
#
# run ruby -I test test/functional/notes_controller_test.rb from eileensnotes folder


require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  # devise authentication methods are being used 
  include Devise::TestHelpers
  
  setup do
    @note = notes(:one)
  end
  
  test "should redirect to login" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
    
    get :destroy, :id => @note.to_param
    assert_response :redirect
    assert_redirected_to new_user_session_path
    
    get :edit, :id => @note.to_param
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should get index" do
    sign_in users(:one)
    get :index
    assert_response :success
    #assert_select 'span#loggedin', :count => 1
    assert_not_nil assigns(:notes)
  end
  
  test "should get new" do
    sign_in users(:one)
    get :new
    assert_response :success
  end

  test "should create note" do
    sign_in users(:one)
    assert_difference('Note.count') do
      post :create, note: { title: @note.title, question: @note.question }
    end
    assert_redirected_to notes_path
    # check the flash notice message
    assert_match 'You have successfully posted your question', flash[:notice] 
  end

  test "should get edit" do
    sign_in users(:one)
    get :edit, id: @note
    assert_response :success
  end

  test "should update note" do
    sign_in users(:one)
    patch :update, id: @note, note: { title: @note.title, question: @note.question }
    assert_redirected_to notes_path
    # check the flash notice message
    assert_match 'You have successfully updated your question.', flash[:notice]
  end

  test "should update only allowed columns" do
    sign_in users(:one)
    patch :update, id: @note, note: { title: @note.title, question: @note.question, user_id: 999 }
    # confirmed column should be unchanged!!!!
    assert_not_equal 999, Note.find(notes(:one).id).user_id
  end    

  test "should destroy note" do
    sign_in users(:one)
    assert_difference('Note.count', -1) do
      delete :destroy, id: @note
    end
    assert_redirected_to notes_path
    # check the flash notice message
    assert_match 'You have successfully deleted your question.', flash[:notice]
  end
end
