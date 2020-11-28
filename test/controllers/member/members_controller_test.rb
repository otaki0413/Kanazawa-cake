require 'test_helper'

class Member::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get member_members_index_url
    assert_response :success
  end

  test "should get edit" do
    get member_members_edit_url
    assert_response :success
  end

  test "should get update" do
    get member_members_update_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get member_members_unsubscribe_url
    assert_response :success
  end

  test "should get retire" do
    get member_members_retire_url
    assert_response :success
  end

end
