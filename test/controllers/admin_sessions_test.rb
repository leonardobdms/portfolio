require "test_helper"

class AdminSessionsTest < ActionDispatch::IntegrationTest
  setup { @admin = admins(:one) }

  test "new" do
    get new_admin_session_path

    assert_response :success
    assert_inertia_component "auth/login"
  end

  test "create with valid credentials" do
    post admin_session_path, params: { admin: { email: @admin.email, password: "password" } }

    assert_redirected_to Avo.configuration.root_path
  end

  test "create with invalid credentials" do
    post admin_session_path, params: { admin: { email: @admin.email, password: "wrong" } }

    assert_response :unprocessable_content
    assert_inertia_component "auth/login"
  end

  test "destroy" do
    sign_in @admin

    delete destroy_admin_session_path

    assert_redirected_to new_admin_session_path
  end

  test "password new" do
    get new_admin_password_path

    assert_response :success
    assert_inertia_component "auth/passwords/new"
  end

  test "avo requires authentication" do
    get Avo.configuration.root_path

    assert_redirected_to new_admin_session_path
  end

  test "avo allows a signed in admin" do
    sign_in @admin

    get Avo.configuration.root_path

    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end
