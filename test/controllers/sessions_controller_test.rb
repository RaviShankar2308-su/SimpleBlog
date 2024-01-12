# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'User sign in via email and password' do
    user = User.create(email: 'test@example.com', password: '12345678', username: 'test')
    session_params = {
      email: 'test@example.com',
      password: '12345678'
    }
    post login_path, params: session_params
    assert_response :ok
    assert_equal(user.id, session[:user_id])
    assert_not_nil session[:user_id]
  end

  test 'User sign in via username and password' do
    user = User.create(email: 'test@example.com', password: '12345678', username: 'test')
    session_params = {
      username: 'test',
      password: '12345678'
    }
    post login_path, params: session_params
    assert_response :ok
    assert_equal(user.id, session[:user_id])
    assert_not_nil session[:user_id]
  end

  test 'Invalid email' do
    User.create(email: 'test@example.com', password: '12345678', username: 'test')
    session_params = {
      email: 'invalid_email@example.com',
      password: '12345678'
    }
    post login_path, params: session_params
    assert_response :unauthorized
    assert_nil session[:user_id]
  end

  test 'Invalid username' do
    User.create(email: 'test@example.com', password: '12345678', username: 'test')
    session_params = {
      username: 'invalid_username',
      password: '12345678'
    }
    post login_path, params: session_params
    assert_response :unauthorized
    assert_nil session[:user_id]
  end

  test 'Invalid password' do
    User.create(email: 'test@example.com', password: '12345678', username: 'test')
    session_params = {
      email: 'invalid_email@example.com',
      password: '1234567'
    }
    post login_path, params: session_params
    assert_response :unauthorized
    assert_nil session[:user_id]
  end

  test 'logout user' do
    delete logout_path

    assert_nil session[:user_id]
    assert_response :success
  end
end
