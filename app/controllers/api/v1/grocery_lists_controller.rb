module Api
  module V1
    class GroceryListsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_grocery_list, only: [:show, :update, :destroy, :save_full_list, :edit_full_list]

      # GET /api/v1/grocery_lists
      def index
        @grocery_lists = current_user.grocery_lists.all

        render json: @grocery_lists
      end

      # GET /api/v1/grocery_lists/:id
      def show
        @groups = @grocery_list.grocery_list_groups
        toReturn = { listId: @grocery_list.id, name: @grocery_list.name, sales_tax: @grocery_list.sales_tax, budget: @grocery_list.budget, list: [] }
        @groups.each do |g|
          groupHash = {groupName: g.name,items:[]}
          g.grocery_list_items.each do |i|
            itemHash = {id:i.id,name:i.name,cost:i.cost,qty:i.qty}
            groupHash[:items] << itemHash
          end
          toReturn[:list] << groupHash
        end
        render json: toReturn
      end

      # POST /api/v1/grocery_lists
      def create
        @grocery_list = current_user.grocery_lists.build(grocery_list_params)

        if @grocery_list.save
          render json: @grocery_list, status: :created, location: @grocery_list
        else
          render json: @grocery_list.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/grocery_lists/:id
      def update
        if @grocery_list.update(grocery_list_params)
          render json: @grocery_list
        else
          render json: @grocery_list.errors, status: :unprocessable_entity
        end
      end

      # POST /api/v1/create_full_list/
      def create_full_list
        @grocery_list = current_user.grocery_lists.build(grocery_list_params)

        if @grocery_list.save
          save_full_list
        else
          render json: @grocery_list.errors, status: :unprocessable_entity
        end
      end

      # PATCH /api/v1/edit_full_list/:id
      def edit_full_list
        @grocery_list.grocery_list_groups.destroy_all
        
        save_full_list
      end

      def save_full_list
        list = params[:list];

        # iterate through list saving groups then items
        count=0
        list.each do |g|
          @group = @grocery_list.grocery_list_groups.create(name: g[:groupName], sort:count)
          count+=1

          # iterate through items saving them to the group
          g[:items].each do |i|
            @group.grocery_list_items.create(name: i[:name], cost: i[:cost], qty: i[:qty])
          end
        end

        render json: { listId: @grocery_list.id }
      end

      # DELETE /api/v1/grocery_lists/:id
      def destroy
        @grocery_list.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_grocery_list
          @grocery_list = current_user.grocery_lists.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def grocery_list_params
          params.require(:grocery_list).permit(:name, :default, :budget, :sales_tax, :total, :user_id)
        end
    end
  end 
end
