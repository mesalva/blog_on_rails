require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  setup do
    Post.delete_all
    User.delete_all
    @user = User.create(name: "name", email: "email@email.com", password: "password")
    @post = Post.create(author: "teste", title: "Title", body: "body", created_at: Time.now, user: @user)
  end

  test "should create a post sucessfully" do
  	assert @post.valid?
  end

  test "should raise an excepion when title is duplicated" do
    assert_raises(Exception){
    	Post.create!(author: "teste", title: "Title", body: "body", created_at: Time.now)
    }
  end

  test "should raise an exception when some field is nil" do
  	valid_attributes = {author: "teste", title: "Title", body: "body"}
  	
  	valid_attributes.each do |key,value|
  		invalid_attributes = valid_attributes.merge({key => nil})
  		assert_raises(Mongoid::Errors::Validations){ Post.create! invalid_attributes }	
  	end
  end

  test "should raise an exception when some field is empty" do
  	valid_attributes = {author: "teste", title: "Title", body: "body"}
  	
  	valid_attributes.each do |key,value|
  		invalid_attributes = valid_attributes.merge({key => ' '})
  		assert_raises(Mongoid::Errors::Validations){ Post.create! invalid_attributes }	
  	end
  end

  #validates_presence_of :title, :body, :author  

  #before_create :set_created_at
end
