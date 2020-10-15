class SigninController < ApplicationController
  before_action :authorize_access_request!, only: [:destroy,:update,:show]
  before_action :current_user, only: [:show, :update]

  # LOGIN
  def create
    user = User.find_by(email: params[:email])
            # authenticate from bcrypt
    if user && user.authenticate(params[:password])
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login
      response.set_cookie(JWTSessions.access_cookie,
                        value: tokens[:access],
                        httponly: true,
                        secure: Rails.env.production?)
      render json: { csrf: tokens[:csrf] }
    else
      # method in application controller
      not_found
    end
  end

  def update
    checkUser = User.find_by(email: params[:email])
    if checkUser && checkUser.id != @current_user.id
      render json: { error: "Email address unavailable. Please choose another." }, status: :unprocessable_entity
    else      
      if @current_user.update(user_params)
        render json: @current_user
      else
        render json: @current_user.errors, status: :unprocessable_entity
      end
    end
  end

  # LOGOUT
  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

  def show
    render json: { first_name: current_user.first_name, last_name: current_user.last_name, email: current_user.email }
  end

  private

  def current_user
    @current_user = User.find(payload["user_id"])
  end

  def not_found
    render json: { error: "Cannot find email / password combination." }, status: :not_found
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end