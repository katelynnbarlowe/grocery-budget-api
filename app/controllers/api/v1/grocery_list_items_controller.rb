module Api
  module V1
    class GroceryListItemsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_grocery_list_item, only: [:show, :update, :destroy]
      before_action :set_grocery_list, only: [:index, :create]

      # GET /api/v1/grocery_lists/:grocery_list_id/grocery_list_groups/:grocery_list_group_id/grocery_list_items
      def index
        @grocery_list_items = @grocery_list.grocery_list_items.all

        render json: @grocery_list_items
      end

      # GET /api/v1/grocery_lists/:grocery_list_id/grocery_list_groups/:grocery_list_group_id/grocery_list_items/:id
      def show
        render json: @grocery_list_item
      end

      # POST /api/v1/grocery_lists/:grocery_list_id/grocery_list_groups/:grocery_list_group_id/grocery_list_items
      def create
        @grocery_list_group = @grocery_list.find(params[:grocery_list_group_id])
        @grocery_list_item = @grocery_list_group.build(grocery_list_item_params)

        if @grocery_list_item.save
          render json: @grocery_list_item, status: :created, location: @grocery_list_item
        else
          render json: @grocery_list_item.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/grocery_lists/:grocery_list_id/grocery_list_groups/:grocery_list_group_id/grocery_list_items/:id
      def update
        if @grocery_list_item.update(grocery_list_item_params)
          render json: @grocery_list_item
        else
          render json: @grocery_list_item.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/grocery_lists/:grocery_list_id/grocery_list_groups/:grocery_list_group_id/grocery_list_items/:id
      def destroy
        @grocery_list_item.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_grocery_list_item
          @grocery_list_item = GroceryListItem.find(params[:id])
        end

        def set_grocery_list
          @grocery_list = current_user.grocery_lists.find(params[:grocery_list_id])
        end

        # Only allow a trusted parameter "white list" through.
        def grocery_list_item_params
          params.require(:grocery_list_item).permit(:name, :cost, :qty, :user_id, :grocery_list_group_id)
        end
    end
  end
end
