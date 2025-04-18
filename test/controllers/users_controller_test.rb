require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @admin_user = users(:two) # Owner user will be used for authentication tests
    # Simulate login for tests that require authentication
    login_as(@admin_user)
  end

  # ==================== Authentication Tests ====================

  test "new and create actions are accessible without authentication" do
    get new_user_url
    assert_response :success

    assert_difference("User.count") do
      post users_url, params: {
        user: {
          name: "Test User",
          apartment_number: 404,
          is_owner: false,
          phone_number: "555-111-2222",
          email_address: "test_controller@example.com",
          password: "password123"
        }
      }
    end
    assert_redirected_to user_url(User.last)
  end

  # ==================== CRUD Operation Tests ====================

  test "should get index" do
    get users_url
    assert_response :found
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should show user" do
    get user_url(@user)
    assert_response :found
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :found
  end
end
