require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    Post.delete_all
    User.delete_all
    @user = User.create(name: "name", email: "email@email.com", password: "password")
    @post = Post.create(body: "body", author: "author", title: "title", user: @user)
    @comment = Comment.create!(body: "body", author: "author", post: @post, user: @user)
  end

  test "should create comment" do
    post :create, comment: { author: @comment.author, body: @comment.body, created_at: @comment.created_at, post_id: @post.id, user: @user}
    assert_response :created
  end

  test "should update comment" do
    patch :update, id: @comment, comment: { author: @comment.author, body: @comment.body, post_id: @post.id}
    assert_response :ok
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment
    end
    assert_response :no_content
  end

  test "should return unprocessable entity on validation error" do
    post :create, comment: { author: '', body: '', created_at: @comment.created_at, post_id: @post.id, user: @user}
    assert_response :unprocessable_entity
  end

  
end
