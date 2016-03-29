# unit test 
#
# - make sure we test all attributes with CRUD for each model
# - by Jae Lee, June 8th 2012
#
# - upgraded to Rails 4 and ran a unit test on Nov 18th 2013
#
# run ruby -I test test/unit/ad_test.rb from eileensnotes folder

require 'test_helper'

class AdTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  # if "validates" is used in a model, try to create an object this way in Unit Test
  # create a new object Ad
  def new_ad(attributes = {})
    # get user object first from the fixture
    user = users(:one)
    # assign 
    attributes[:ad_title] ||= nil
    attributes[:ad_content] ||= nil
    ad = Ad.new(attributes)
    ad.user_id = user.id
    ad.valid?
    ad
  end
  
  # check if a new object is created ok
  test "this_should_create_ad" do
    a = new_ad(:ad_title => 'test', :ad_content => 'question')
    assert a.valid?
  end
  
  # check if the data is valid
  test "this_should_check_if_data_is_valid" do
    a = Ad.new
    # the data was not given
    assert !a.valid?
    
    # create a note and check if it asserts equal
    a.ad_title = 'test string'
    a.ad_content = 'test question'
    assert a.valid?
    
    assert_equal a.ad_title, 'test string'
    assert_equal a.ad_content, 'test question'
  end
  
  # check if empty fields are checked
  test "this_should_fail_empty_ad" do
    # content field is empty
    a = new_ad(:ad_title => 'test')
    assert a.errors[:ad_content].present?
    # title field is empty
    a = new_ad(:ad_content => 'test')
    assert a.errors[:ad_title].present?
  end
 
  # check if validation_length is run.
  test "this_should_fail_ad_too_long" do
    test_to_be_tested = ""
    for i in (1..105)
      test_to_be_tested = test_to_be_tested + i.to_s
    end 
    # title is too long here
    a = new_ad(:ad_title    => test_to_be_tested, :ad_content => 'test')
    assert a.errors[:ad_title].present?
    
    test_to_be_tested = ""
    for i in (1..3010)
      test_to_be_tested = test_to_be_tested + i.to_s
    end
    # question is too long here
    a = new_ad(:ad_title => 'title', :ad_content => test_to_be_tested)
    assert a.errors[:ad_content].present?
  end
end
