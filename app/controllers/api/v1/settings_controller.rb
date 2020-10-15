module Api
  module V1
    class SettingsController < ApplicationController
      before_action :authorize_access_request!, only: [:index,:show,:show_by_code,:create,:update]
      before_action :set_setting, only: [:show, :update, :destroy]
      before_action :set_setting_by_code, only: [:show_by_code]

      # GET /settings
      def index
        @settings = current_user.settings

        render json: @settings
      end

      # GET /settings/1
      def show
        render json: @setting
      end

      # GET /settings/code/budget
      def show_by_code
        render json: @setting
      end

      # POST /settings
      def create
        @setting = Setting.new(setting_params)

        if @setting.save
          render json: @setting, status: :created, location: @setting
        else
          render json: @setting.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /settings/1
      def update
        if @setting.update(setting_params)
          render json: @setting
        else
          render json: @setting.errors, status: :unprocessable_entity
        end
      end

      # DELETE /settings/1
      def destroy
        @setting.destroy
      end

      private

        def current_user
          @current_user = User.find(payload["user_id"])
        end

        # Use callbacks to share common setup or constraints between actions.
        def set_setting
          @setting = Setting.find(params[:id])
        end

        # Use callbacks to share common setup or constraints between actions.
        def set_setting_by_code
          @setting = current_user.settings.where(code: params[:code]).take
        end

        # Only allow a trusted parameter "white list" through.
        def setting_params
          params.require(:setting).permit(:code, :value, :user_id)
        end
    end
  end
end
