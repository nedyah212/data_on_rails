require "application_system_test_case"

class SalespeopleTest < ApplicationSystemTestCase
  setup do
    @salesperson = salespeople(:one)
  end

  test "visiting the index" do
    visit salespeople_url
    assert_selector "h1", text: "Salespeople"
  end

  test "should create salesperson" do
    visit salespeople_url
    click_on "New salesperson"

    fill_in "Dealership", with: @salesperson.dealership_id
    fill_in "Person", with: @salesperson.person_id
    click_on "Create Salesperson"

    assert_text "Salesperson was successfully created"
    click_on "Back"
  end

  test "should update Salesperson" do
    visit salesperson_url(@salesperson)
    click_on "Edit this salesperson", match: :first

    fill_in "Dealership", with: @salesperson.dealership_id
    fill_in "Person", with: @salesperson.person_id
    click_on "Update Salesperson"

    assert_text "Salesperson was successfully updated"
    click_on "Back"
  end

  test "should destroy Salesperson" do
    visit salesperson_url(@salesperson)
    click_on "Destroy this salesperson", match: :first

    assert_text "Salesperson was successfully destroyed"
  end
end
