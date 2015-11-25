require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  setup do
  	User.delete_all
    @user = User.create(name: "name", email: "email@email.com", password: "password")
  end

  test "should create a user sucessfully" do
  	assert @user.valid?
  end

  test "should hash password sucessfully" do
  	password_hashed = Digest::SHA1.hexdigest('password')
  	assert_equal @user.password, password_hashed
  end

  test "should raise an excepion when email is duplicated" do
    assert_raises(Exception){
    	User.create!(name: "name2", email: "email@email.com", password: "password2")
    }
  end

  test "should raise an excepion when email is out of format" do
    assert_raises(Exception){
    	User.create!(name: "name3", email: "email@@email.com", password: "password3")
    }
  end

  test "should validate the required fields, returning error messages" do
  	valid_attributes = {name: "name", email: "email2@email.com", password: "password"}
  	
  	valid_attributes.each do |k,v|
  		invalid_attributes = valid_attributes.merge({k => nil})	
	  	assert_raises(Mongoid::Errors::Validations){
	    	User.create! invalid_attributes
	    }	
  	end

  	valid_attributes.each do |k,v|
  		invalid_attributes = valid_attributes.merge({k => " "})	
	  	assert_raises(Mongoid::Errors::Validations){
	    	User.create! invalid_attributes
	    }	
  	end
     
  end
end
