# frozen_string_literal: true

# First it will authorize the request
# It will return the value according to the calling method
# if the index method called then, it will return all the posts of the current user
# if the create method called then, current user is able to create his posts
class PostsController < ApplicationController
  before_action :check_login, only: %i[index create]

  def index
    posts = current_user.posts
    render json: posts
  end

  def create
    post = Post.new(post_params)
    post.user = current_user

    if post.save
      render json: { post: post, status: :created }
    else
      render :json, { message: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private 

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def check_login
    render json: { error: 'You need to login' }, status: :unauthorized unless session[:user_id]
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end
