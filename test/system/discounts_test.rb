require "application_system_test_case"

class DiscountsTest < ApplicationSystemTestCase
  setup do
    @discount = discounts(:one)
  end

  test "visiting the index" do
    visit discounts_url
    assert_selector "h1", text: "Discounts"
  end

  test "creating a Discount" do
    visit discounts_url
    click_on "New Discount"

    fill_in "Kind", with: @discount.kind
    fill_in "Name", with: @discount.name
    fill_in "Price", with: @discount.price
    fill_in "Product ids", with: @discount.product_ids
    click_on "Create Discount"

    assert_text "Discount was successfully created"
    click_on "Back"
  end

  test "updating a Discount" do
    visit discounts_url
    click_on "Edit", match: :first

    fill_in "Kind", with: @discount.kind
    fill_in "Name", with: @discount.name
    fill_in "Price", with: @discount.price
    fill_in "Product ids", with: @discount.product_ids
    click_on "Update Discount"

    assert_text "Discount was successfully updated"
    click_on "Back"
  end

  test "destroying a Discount" do
    visit discounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Discount was successfully destroyed"
  end
end
