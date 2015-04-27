require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  test "login with invalid information" do
    get login_path # Go to login screen
    assert_template 'sessions/new' # ASSERT: login screen renders
    post login_path, session: { email: "", password: "" } # Post invalid user creds
    assert_template 'sessions/new' # ASSERT: login screen renders again
    assert_not flash.empty? # ASSERT: Error displayed on screen
    get root_path # Go to another page (in this case Home)
    assert flash.empty? # ASSERT: Error not displayed on new screen
  end


end
