require 'test_helper'

class PersonalWebsitesControllerTest < ActionController::TestCase
  setup do
    @personal_website = personal_websites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personal_websites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create personal_website" do
    assert_difference('PersonalWebsite.count') do
      post :create, personal_website: { url: @personal_website.url }
    end

    assert_redirected_to personal_website_path(assigns(:personal_website))
  end

  test "should show personal_website" do
    get :show, id: @personal_website
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @personal_website
    assert_response :success
  end

  test "should update personal_website" do
    patch :update, id: @personal_website, personal_website: { url: @personal_website.url }
    assert_redirected_to personal_website_path(assigns(:personal_website))
  end

  test "should destroy personal_website" do
    assert_difference('PersonalWebsite.count', -1) do
      delete :destroy, id: @personal_website
    end

    assert_redirected_to personal_websites_path
  end
end
