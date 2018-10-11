require 'test_helper'

class MmocontrollerControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get mmocontroller_top_url
    assert_response :success
  end

  test "should get index" do
    get mmocontroller_index_url
    assert_response :success
  end

  test "should get new" do
    get mmocontroller_new_url
    assert_response :success
  end

  test "should get create" do
    get mmocontroller_create_url
    assert_response :success
  end

  test "should get show" do
    get mmocontroller_show_url
    assert_response :success
  end

  test "should get jcre" do
    get mmocontroller_jcre_url
    assert_response :success
  end

  test "should get destroy" do
    get mmocontroller_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get mmocontroller_edit_url
    assert_response :success
  end

end
