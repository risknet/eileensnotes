# unit test 
#
# - make sure we test all attributes with CRUD for each model
# - by Jae Lee, June 8th 2012
#
# - upgraded to Rails 4 and ran a unit test on Nov 18th 2013
#
# run ruby -I test test/unit/answer_test.rb from eileensnotes folder

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  # if "validates" is used in a model, try to create an object this way in Unit Test
  # create a new object Answer
  def new_answer(attributes = {})
    # get user object first from the fixture
    user = users(:one)
    note = notes(:one)
    # assign 
    attributes[:answer] ||= nil
    answer = Answer.new(attributes)
    answer.user_id = user.id
    answer.note_id = note.id
    answer.valid?
    answer
  end
  
  # check if a new object is created ok
  test "this_should_create_answer" do
    a = new_answer(:answer => 'test')
    assert a.valid?
  end
  
  # check if the data is valid
  test "this_should_check_if_data_is_valid" do
    a = Answer.new
    # the data was not given
    assert !a.valid?
    
    # create an answer and check if it asserts equal
    a.answer = 'test string'
    assert a.valid?
    
    assert_equal a.answer, 'test string'
  end
  
  # check if empty fields are checked
  test "this_should_fail_empty_note" do
    # answer field is empty
    a = new_answer(:answer => '')
    assert a.errors[:answer].present?
  end
  
  # check if validation_length is run.
  test "this_should_fail_answer_too_long" do
    test_to_be_tested = ""
    for i in (1..3010)
      test_to_be_tested = test_to_be_tested + i.to_s
    end
    # question is too long here
    a = new_answer(:answer => test_to_be_tested)
    assert a.errors[:answer].present?
  end
  
end
