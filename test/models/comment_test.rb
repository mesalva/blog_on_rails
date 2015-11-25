require 'test_helper'

class CommentTest < ActiveSupport::TestCase

	setup do
		Post.delete_all
    	@user = User.create(name: "name", email: "email@email.com", password: "password")
		@post = Post.create!(body: "body", author: "author", title: "title", user: @user)
		@comment = Comment.create!(body: "body", author: "author", post: @post, user: @user)
	end

	test "validate presence of author" do
  		comment = Comment.create(body: "body", post: @post)
  		assert_not comment.valid?
  		assert_equal comment.errors.full_messages.first, "Author can't be blank"
	end

	test "validate presence of body" do
  		comment = Comment.create(author: "author", post: @post)
  		assert_not comment.valid?
  		assert_equal comment.errors.full_messages.first, "Body can't be blank"
	end

	test "load a comment sucessfully" do
		comment = Comment.find(@comment.id)
		assert_equal comment.post, @post
	end

end