require "test_helper"

class BoatsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get boats_edit_url
    assert_response :success
  end

  test "should get index" do
    get boats_index_url
    assert_response :success
  end

  test "should get new" do
    get boats_new_url
    assert_response :success
  end

  test "should get show" do
    get boats_show_url
    assert_response :success
  end
end
