require 'test_helper'

class GroceryListItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grocery_list_item = grocery_list_items(:one)
  end

  test "should get index" do
    get grocery_list_items_url, as: :json
    assert_response :success
  end

  test "should create grocery_list_item" do
    assert_difference('GroceryListItem.count') do
      post grocery_list_items_url, params: { grocery_list_item: { cost: @grocery_list_item.cost, grocery_list_group_id: @grocery_list_item.grocery_list_group_id, name: @grocery_list_item.name, qty: @grocery_list_item.qty, user_id: @grocery_list_item.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show grocery_list_item" do
    get grocery_list_item_url(@grocery_list_item), as: :json
    assert_response :success
  end

  test "should update grocery_list_item" do
    patch grocery_list_item_url(@grocery_list_item), params: { grocery_list_item: { cost: @grocery_list_item.cost, grocery_list_group_id: @grocery_list_item.grocery_list_group_id, name: @grocery_list_item.name, qty: @grocery_list_item.qty, user_id: @grocery_list_item.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy grocery_list_item" do
    assert_difference('GroceryListItem.count', -1) do
      delete grocery_list_item_url(@grocery_list_item), as: :json
    end

    assert_response 204
  end
end
