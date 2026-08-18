require "test_helper"

class AdminTest < ActiveSupport::TestCase
  test "requires email and password" do
    admin = Admin.new

    assert_not admin.valid?
    assert_includes admin.errors[:email], admin.errors.generate_message(:email, :blank)
    assert_includes admin.errors[:password], admin.errors.generate_message(:password, :blank)
  end

  test "keeps current password when the new password is blank" do
    admin = admins(:one)
    previous_password = admin.encrypted_password

    admin.update!(password: "", password_confirmation: "")

    assert_equal previous_password, admin.reload.encrypted_password
  end

  test "exposes the email as the display name" do
    admin = Admin.new(email: "admin@example.com")

    assert_equal "admin@example.com", admin.name
    assert admin.is_admin?
  end
end
