# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def login_as
    @user = User.create(email: 'test@example.com', password: '12345678', username: 'test')
    session_params = {
      email: 'test@example.com',
      password: '12345678'
    }
    post login_path, params: session_params
  end

  test 'GET index returns user posts' do
    login_as

    get posts_path
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal @user.posts.count, json.size
  end

  test 'POST create makes new post for user' do
    login_as

    post_params = { title: 'New Post', content: 'Lorem Ipsum' }

    post posts_path, params: { post: post_params }
    assert_response :created

    json = JSON.parse(response.body)
    new_post = @user.posts.last

    assert_equal new_post.title, json['post']['title']
  end

  test 'Unauthenticated user cannot access' do
    get posts_path
    assert_response :unauthorized

    post posts_path
    assert_response :unauthorized
  end
end
