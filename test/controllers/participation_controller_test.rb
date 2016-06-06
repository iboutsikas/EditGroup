require 'test_helper'

class ParticipationControllerTest < ActionController::TestCase
  test "should get administrative_title" do
    get :administrative_title
    assert_response :success
  end

  test "should get email" do
    get :email
    assert_response :success
  end

end
