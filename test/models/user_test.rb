require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid_user)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved as lowercase" do
    mixed_case_email = "UsEr@ExAmPlE.CoM"
    @user.email = mixed_case_email
    assert @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
