require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get members" do
    get :members
    assert_response :success
  end

  test "should get projects" do
    get :projects
    assert_response :success
  end

  test "should get publications" do
    get :publications
    assert_response :success
  end

  test "should get news-events" do
    get :news-events
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
