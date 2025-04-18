require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = users(:one)
    assert user.valid?
  end

  test "requires name" do
    user = users(:one)
    user.name = nil
    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
  end

  test "requires apartment_number" do
    user = users(:one)
    user.apartment_number = nil
    assert_not user.valid?
    assert_includes user.errors[:apartment_number], "can't be blank"
  end

  test "requires phone_number" do
    user = users(:one)
    user.phone_number = nil
    assert_not user.valid?
    assert_includes user.errors[:phone_number], "can't be blank"
  end

  test "requires email_address" do
    user = users(:one)
    user.email_address = nil
    assert_not user.valid?
    assert_includes user.errors[:email_address], "can't be blank"
  end

  test "email address must be unique" do
    user = User.new(
      name: "Test User",
      apartment_number: 505,
      is_owner: false,
      phone_number: "555-555-5555",
      email_address: users(:one).email_address,
      password: "password123"
    )
    assert_not user.valid?
    assert_includes user.errors[:email_address], "has already been taken"
  end

  test "email normalizes to lowercase and strips whitespace" do
    user = User.new(
      name: "Test User",
      apartment_number: 505,
      is_owner: false,
      phone_number: "555-555-5555",
      email_address: " Test@EXAMPLE.com ",
      password: "password123"
    )
    user.save
    assert_equal "test@example.com", user.email_address
  end

  test "requires password for new record" do
    user = User.new(
      name: "Test User",
      apartment_number: 505,
      is_owner: false,
      phone_number: "555-555-5555",
      email_address: "test@example.com"
    )
    assert_not user.valid?
    assert_includes user.errors[:password], "can't be blank"
  end

  # Test that passwords are not required for updates to existing records
  test "does not require password for existing record" do
    # Arrange
    @user = users(:one)
    @user.name = "New Name"
    # Act & Assert
    assert @user.valid?
    assert @user.save
    assert_equal "New Name", @user.reload.name
  end

  test "can update attributes without password" do
    user = users(:one)
    user.name = "Updated Name"
    assert user.valid?
    assert user.save
    assert_equal "Updated Name", user.reload.name
  end

  test "boolean validation for is_owner" do
    user = users(:one)
    user.is_owner = nil
    assert_not user.valid?
    assert_includes user.errors[:is_owner], "must be true or false"
  end

  test "can authenticate with correct password" do
    user = users(:one)
    assert user.authenticate("password")
  end

  test "cannot authenticate with incorrect password" do
    user = users(:one)
    assert_not user.authenticate("wrong_password")
  end
end
