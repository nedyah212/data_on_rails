require "test_helper"

class SalespeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @salesperson = salespeople(:one)
  end

  test "should get index" do
    get salespeople_url
    assert_response :success
  end

  test "should get new" do
    get new_salesperson_url
    assert_response :success
  end

  test "should create salesperson" do
    assert_difference("Salesperson.count") do
      post salespeople_url, params: { salesperson: { dealership_id: @salesperson.dealership_id, person_id: @salesperson.person_id } }
    end

    assert_redirected_to salesperson_url(Salesperson.last)
  end

  test "should show salesperson" do
    get salesperson_url(@salesperson)
    assert_response :success
  end

  test "should get edit" do
    get edit_salesperson_url(@salesperson)
    assert_response :success
  end

  test "should update salesperson" do
    patch salesperson_url(@salesperson), params: { salesperson: { dealership_id: @salesperson.dealership_id, person_id: @salesperson.person_id } }
    assert_redirected_to salesperson_url(@salesperson)
  end

  test "should destroy salesperson" do
    assert_difference("Salesperson.count", -1) do
      delete salesperson_url(@salesperson)
    end

    assert_redirected_to salespeople_url
  end
end
