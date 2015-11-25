require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    User.delete_all
    @user = User.create!({name: "user", email: "mail@mail.com", password: "password"})
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { description: @user.description, email: 'novo@mail.com', name: @user.name, password: @user.password }
    end

    assert_response :created
  end

  test "should update user" do
    patch :update, id: @user, user: { description: @user.description, email: @user.email, name: @user.name, password: @user.password }
    assert_response :ok
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_response :no_content
  end
end
