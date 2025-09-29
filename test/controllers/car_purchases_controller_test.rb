require "test_helper"

class CarPurchasesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get car_purchases_index_url
    assert_response :success
  end

  test "should get show" do
    get car_purchases_show_url
    assert_response :success
  end
end
