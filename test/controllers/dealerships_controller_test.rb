require "test_helper"

class DealershipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dealerships_index_url
    assert_response :success
  end

  test "should get show" do
    get dealerships_show_url
    assert_response :success
  end
end
