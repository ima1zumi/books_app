# frozen_string_literal: true

require "application_system_test_case"

class OmniauthUsersTest < ApplicationSystemTestCase
  setup do
    OmniAuth.config.mock_auth[:github] = set_omniauth("github")
  end

  test "GitHub連携でサインアップする" do
    visit "ja/users/sign_in"
    click_link "GitHubでログイン"
    assert_text "Github アカウントによる認証に成功しました。"
  end
end
