require 'test_helper'

class FormCreatorsControllerTest < ActionController::TestCase
  setup do
    @form_creator = form_creators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:form_creators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create form_creator" do
    assert_difference('FormCreator.count') do
      post :create, form_creator: { c: @form_creator.c, rails: @form_creator.rails }
    end

    assert_redirected_to form_creator_path(assigns(:form_creator))
  end

  test "should show form_creator" do
    get :show, id: @form_creator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @form_creator
    assert_response :success
  end

  test "should update form_creator" do
    patch :update, id: @form_creator, form_creator: { c: @form_creator.c, rails: @form_creator.rails }
    assert_redirected_to form_creator_path(assigns(:form_creator))
  end

  test "should destroy form_creator" do
    assert_difference('FormCreator.count', -1) do
      delete :destroy, id: @form_creator
    end

    assert_redirected_to form_creators_path
  end
end
