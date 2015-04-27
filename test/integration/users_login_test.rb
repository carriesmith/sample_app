require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  test "login with invalid information" do
    get login_path # Visit login page
    assert_template 'sessions/new' # ASSERT: Login screen renders
    post login_path, session: { email: "", password: "" } # Submit invalid user credentials
    assert_template 'sessions/new' # ASSERT: Login screen renders
    assert_not flash.empty? # ASSERT: Error message appears on the screen
    get root_path # Visit a new page (e.g. Home)
    assert flash.empty?, "Error message persists on new page after invalid login" # ASSERT: Error message should be cleared after visiting a new page
  end

end
