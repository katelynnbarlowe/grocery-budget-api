module Api
  module V1
    class GroceryListGroupsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_grocery_list_group, only: [:show, :update, :destroy]
      before_action :set_grocery_list, only: [:index, :create]

      # GET /api/v1/grocery_lists/:grocery_list_id/grocery_list_groups
      def index
        render json: @grocery_list.grocery_list_groups.all
      end

      # GET /api/v1/grocery_lists/:grocery_list_id/grocery_list_groups/:id
      def show
        render json: @grocery_list_group 
      end

      # POST /api/v1/grocery_lists/:grocery_list_id/grocery_list_groups
      def create
        @grocery_list_group = @grocery_list.grocery_list_groups.create(grocery_list_group_params)

        if @grocery_list_group.save
          render json: @grocery_list_group, status: :created, location: @grocery_list_group
        else
          render json: @grocery_list_group.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/grocery_lists/:grocery_list_id/grocery_list_groups/:id
      def update
        if @grocery_list_group.update(grocery_list_group_params)
          render json: @grocery_list_group
        else
          render json: @grocery_list_group.errors, status: :unprocessable_entity
        end
      end

      # DELETE /grocery_list_groups/1
      def destroy
        @grocery_list_group.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_grocery_list_group
          @grocery_list_group = GroceryListGroup.find(params[:id])
        end

        def set_grocery_list
          @grocery_list = current_user.grocery_list.find(params[:grocery_list_id])
        end

        # Only allow a trusted parameter "white list" through.
        def grocery_list_group_params
          params.require(:grocery_list_group).permit(:name, :user_id, :sort, :grocery_list_id)
        end
    end
  end
end
