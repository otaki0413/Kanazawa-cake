require 'test_helper'

class Member::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get member_products_index_url
    assert_response :success
  end

  test "should get show" do
    get member_products_show_url
    assert_response :success
  end

end
