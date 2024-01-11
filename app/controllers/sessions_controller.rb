# frozen_string_literal: true

# It creates the session whenever user login
# User can login by email/username and password
# return the newly created session token
class SessionsController < ApplicationController
  def create
    user = params[:email] ? User.find_by(email: params[:email]) : User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { message: 'Signed In Successfully', status: :ok, email: user.email }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: 'Signed Out Successfully', status: :ok }
  end
end
