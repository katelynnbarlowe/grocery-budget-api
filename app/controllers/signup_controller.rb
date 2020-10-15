class SignupController < ApplicationController
  def create
    checkUser = User.find_by(email: params[:email])
    if checkUser
      render json: { error: "User already exists. Click <a href='/'>here</a> to signin." }, status: :unprocessable_entity
    else
      user = User.new(user_params)
      if user.save
        payload  = { user_id: user.id }
        session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
        		# will create a refresh controller to refresh session
        		# if things aren't going well
        tokens = session.login

        response.set_cookie(JWTSessions.access_cookie,
                            value: tokens[:access],
                            httponly: true,
                            secure: Rails.env.production?)

        # create new settings variables
        user.settings.create(code: "default_budget",value:80)
        user.settings.create(code: "sales_tax",value:4.5)

        render json: { csrf: tokens[:csrf] }
      else
        render json: { error: user.errors.full_messages.join(' ') }, status: :unprocessable_entity
        # 422 code
  	  # all status codes found here: https://gist.github.com/mlanett/a31c340b132ddefa9cca
      end
    end 
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
