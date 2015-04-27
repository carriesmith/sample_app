require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    get login_path # Go to login screen
    assert_template 'sessions/new' # ASSERT: login screen renders
    post login_path, session: { email: "", password: "" } # Post invalid user creds
    assert_template 'sessions/new' # ASSERT: login screen renders again
    assert_not flash.empty? # ASSERT: Error displayed on screen
    get root_path # Go to another page (in this case Home)
    assert flash.empty? # ASSERT: Error not displayed on new screen
  end

  test "login with valid information" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

end
