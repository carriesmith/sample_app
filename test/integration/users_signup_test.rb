require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                                email: "user@nvalid",
                                password: "foo",
                                password_confirmation: "bar"}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {name: "Example Person",
                                            email: "user@valid.com",
                                            password: "foobar",
                                            password_confirmation: "foobar"}
    end
    assert_template 'users/show'
    assert_not flash.nil?, "valid sign in should not prompt error flash"
    assert is_logged_in? # method defined test_helper.rb
  end

end
