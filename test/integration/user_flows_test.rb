require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest
test "can see the welcome page" do
    get "/"
    assert_select "h1", "Welcome"
end

test "can register a new user" do
    get new_user_registration_path
    assert_response :success

    assert_difference('User.count') do
    post user_registration_path, params: { 
        user: { 
        email: "newuser@example.com",
        password: "password123",
        password_confirmation: "password123"
        } 
    }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_select "div", /Signed in successfully/
end

test "can sign in" do
    user = users(:valid_user)

    get new_user_session_path
    assert_response :success

    post user_session_path, params: {
    user: {
        email: user.email,
        password: 'password123'
    }
    }

    assert_redirected_to root_path
    follow_redirect!
    assert_select "div", /Signed in successfully/
end

test "can sign out" do
    sign_in users(:valid_user)
    
    delete destroy_user_session_path
    
    assert_redirected_to root_path
    follow_redirect!
    assert_select "div", /Signed out successfully/
end
end

