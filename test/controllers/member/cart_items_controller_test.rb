require 'test_helper'

class Member::CartItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get member_cart_items_index_url
    assert_response :success
  end

  test "should get update" do
    get member_cart_items_update_url
    assert_response :success
  end

  test "should get destroy" do
    get member_cart_items_destroy_url
    assert_response :success
  end

  test "should get all_destroy" do
    get member_cart_items_all_destroy_url
    assert_response :success
  end

end
