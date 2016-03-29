# unit test 
#
# - make sure we test all attributes with CRUD for each model
# - by Jae Lee, June 8th 2012
#
# - upgraded to Rails 4 and ran a unit test on Nov 18th 2013
#
# run ruby -I test test/unit/note_test.rb from eileensnotes folder

require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  #include Devise::TestHelpers
  
  # if "validates" is used in a model, try to create an object this way in Unit Test
  # create a new object Note
  def new_note(attributes = {})
    # get user object first from the fixture
    user = users(:one)
    # assign 
    attributes[:title] ||= nil
    attributes[:question] ||= nil
    note = Note.new(attributes)
    note.user_id = user.id
    note.valid?
    note
  end
  
  # check if a new object is created ok
  test "this_should_create_note" do
    n = new_note(:title => 'test', :question => 'question')
    assert n.valid?
  end
  
  # check if the data is valid
  test "this_should_check_if_data_is_valid" do
    n = Note.new
    # the data was not given
    assert !n.valid?
    
    # create a note and check if it asserts equal
    n.title = 'test string'
    n.question = 'test question'
    assert n.valid?
    
    assert_equal n.title, 'test string'
    assert_equal n.question, 'test question'
  end
  
  # check if empty fields are checked
  test "this_should_fail_empty_note" do
    # question field is empty
    n = new_note(:title => 'test')
    assert n.errors[:question].present?
    # title field is empty
    n = new_note(:question => 'test')
    assert n.errors[:title].present?
  end
 
  # check if validation_length is run.
  test "this_should_fail_note_too_long" do
    test_to_be_tested = ""
    for i in (1..205)
      test_to_be_tested = test_to_be_tested + i.to_s
    end 
    # title is too long here
    n = new_note(:title    => test_to_be_tested,
                 :question => 'test')
    assert n.errors[:title].present?
    
    test_to_be_tested = ""
    for i in (1..3010)
      test_to_be_tested = test_to_be_tested + i.to_s
    end
    # question is too long here
    n = new_note(:title => 'title', :question => test_to_be_tested)
    assert n.errors[:question].present?
  end
  
end
