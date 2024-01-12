# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should create a new user' do
    user_params = {
      email: 'test@gmail.com',
      username: 'test',
      password: '12345678'
    }
    post signup_path, params: { user: user_params }
    assert_response :created
    assert_not_nil User.find_by(email: 'test@gmail.com')
  end

  test 'Missing Username' do
    user_params = {
      email: 'test@gmail.com',
      password: '12345678'
    }
    post signup_path, params: { user: user_params }
    assert_response :unprocessable_entity
  end
  test 'Missing email' do
    user_params = {
      username: 'test',
      password: '12345678'
    }
    post signup_path, params: { user: user_params }
    assert_response :unprocessable_entity
  end
end
