# frozen_string_literal: true

# return the current user
class ApplicationController < ActionController::API
  def current_user
    User.find_by(id: session[:user_id])
  end
end
