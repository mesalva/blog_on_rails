require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  include AssertJson

  setup do
    Post.destroy_all
    User.delete_all
    @user = User.create(name: "name", email: "email@email.com", password: "password")
    @post = Post.create(author: "teste", title: "Title", body: "body", created_at: Time.now, user: @user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { author: @post.author, body: @post.body, created_at: @post.created_at, title: 'Title 2', user:@user }
    end

    assert_response :created
  end

  
  test "should update post" do
    post :update, id: @post, post: { author: @post.author, body: @post.body, created_at: @post.created_at, title: @post.title }
    assert_response :ok
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_response :no_content
  end

  test "should return unprocessable entity on duplicated post title" do
      post :create, post: { author: @post.author, body: @post.body, created_at: @post.created_at, title: 'Title' }

    assert_response :unprocessable_entity
  end

  test "should return unprocessable entity on empty post title" do
      post :create, post: { author: @post.author, body: @post.body, created_at: @post.created_at, title: nil }

    assert_response :unprocessable_entity
  end

  test "should return unprocessable entity on empty post body" do
      post :create, post: { author: @post.author, body: '', created_at: @post.created_at, title: @post.title }

    assert_response :unprocessable_entity
  end


  test "should return unprocessable entity on empty post author" do
      post :create, post: { author: ' ', body: @post.body, created_at: @post.created_at, title: @post.title }

    assert_response :unprocessable_entity
  end

  test "should return correct posts position" do
    populate_posts

    100.times do |time|  
      get :index, {limit:1, offset:time}
      assert_response :success
      
      assert_json(@response.body) do
        has 'title', "Title #{time}"
      end
    end
    
  end

  def populate_posts
    Post.destroy_all
    100.times do | index |
      Post.create(author: "teste", title: "Title #{index}", body: "body", created_at: Time.now, user: @user)
    end
  end

end
