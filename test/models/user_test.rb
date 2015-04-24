require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.new(name: "Example User", email: "user@example.com",
      password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	
  	# Empty string is not valid name
  	# invalidated by models/user.rb presence of name
  	@user.name = ""
  	assert_not @user.valid?

  	# Ditto
  	@user.name = "    "
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = ""
  	assert_not @user.valid?
  end

  test "name length under 51 characters" do
  	@user.name = "x" * 51
  	assert_not @user.valid?
  end

  test "email length under 256 characters" do
  	@user.email = "x" * 246 + "@gmail.com"
  	assert_not @user.valid?
  end

  test "email validation should accept valid email addy" do
  	valid_emails = %w[user@example.com USER@foo.COM A_US-er@foo.bar.org 
  		first.last@foo.jp alice+bob@wonderful-wedding.org]

  	valid_emails.each do |valid_email|
  		@user.email = valid_email
  		assert @user.valid?, "#{valid_email.inspect} should be valid"
  	end
  end

  test "email validation should reject invalid email addresses" do
  	invalid_emails = %w[user@example,com user_at_foo.com user.name@example.
  			foo@bar_baz.com foo@bar+baz.com]

    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email} is invalid but tested as valid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase # Duplication includes differences in case
    @user.save
    assert_not duplicate_user.valid?, "duplicate -- email address already exists in database"
  end

  test "password minimum length 6 characters" do
    @user.password = @user.password_confirmation = "x" * 5
    assert_not @user.valid?
  end

end
