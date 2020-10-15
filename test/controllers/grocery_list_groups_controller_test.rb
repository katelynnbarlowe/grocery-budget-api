require 'test_helper'

class GroceryListGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grocery_list_group = grocery_list_groups(:one)
  end

  test "should get index" do
    get grocery_list_groups_url, as: :json
    assert_response :success
  end

  test "should create grocery_list_group" do
    assert_difference('GroceryListGroup.count') do
      post grocery_list_groups_url, params: { grocery_list_group: { grocery_list_id: @grocery_list_group.grocery_list_id, name: @grocery_list_group.name, sort: @grocery_list_group.sort, user_id: @grocery_list_group.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show grocery_list_group" do
    get grocery_list_group_url(@grocery_list_group), as: :json
    assert_response :success
  end

  test "should update grocery_list_group" do
    patch grocery_list_group_url(@grocery_list_group), params: { grocery_list_group: { grocery_list_id: @grocery_list_group.grocery_list_id, name: @grocery_list_group.name, sort: @grocery_list_group.sort, user_id: @grocery_list_group.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy grocery_list_group" do
    assert_difference('GroceryListGroup.count', -1) do
      delete grocery_list_group_url(@grocery_list_group), as: :json
    end

    assert_response 204
  end
end
