require 'test_helper'

class WebsiteTemplatesControllerTest < ActionController::TestCase
  setup do
    @website_template = website_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:website_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create website_template" do
    assert_difference('WebsiteTemplate.count') do
      post :create, website_template: { website_name: @website_template.website_name }
    end

    assert_redirected_to website_template_path(assigns(:website_template))
  end

  test "should show website_template" do
    get :show, id: @website_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @website_template
    assert_response :success
  end

  test "should update website_template" do
    patch :update, id: @website_template, website_template: { website_name: @website_template.website_name }
    assert_redirected_to website_template_path(assigns(:website_template))
  end

  test "should destroy website_template" do
    assert_difference('WebsiteTemplate.count', -1) do
      delete :destroy, id: @website_template
    end

    assert_redirected_to website_templates_path
  end
end
