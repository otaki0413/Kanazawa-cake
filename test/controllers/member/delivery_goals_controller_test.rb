require 'test_helper'

class Member::DeliveryGoalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get member_delivery_goals_index_url
    assert_response :success
  end

  test "should get create" do
    get member_delivery_goals_create_url
    assert_response :success
  end

  test "should get edit" do
    get member_delivery_goals_edit_url
    assert_response :success
  end

  test "should get update" do
    get member_delivery_goals_update_url
    assert_response :success
  end

  test "should get destroy" do
    get member_delivery_goals_destroy_url
    assert_response :success
  end

end
