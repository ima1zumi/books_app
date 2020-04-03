# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Warden::Test::Helpers
  setup do
    Warden.test_mode!
    @user = users(:one)
    login_as(@user, scope: :user)
  end

  test "visiting an user" do
    visit user_path(@user.id)
    assert_selector "h1", text: "ユーザー情報"
  end

  test "updating an user" do
    visit user_path(@user.id)
    click_on "プロフィール編集"

    assert has_field?("メールアドレス", with: @user.email)
    assert has_field?("名前", with: @user.name)

    fill_in "郵便番号", with: "123-4567"
    fill_in "住所", with: "40 Example Street London"
    fill_in "自己紹介", with: "妻と犬が好き"
    fill_in "現在のパスワード", with: "password"
    click_on "更新"

    assert_text "アカウント情報を変更しました。"
  end

  test "updating an user failed" do
    visit user_path(@user.id)
    click_on "プロフィール編集"

    assert has_field?("メールアドレス", with: @user.email)
    assert has_field?("名前", with: @user.name)

    fill_in "郵便番号", with: "123-4567"
    fill_in "住所", with: "40 Example Street London"
    fill_in "自己紹介", with: "妻と犬が好き"
    fill_in "現在のパスワード", with: ""
    click_on "更新"

    assert_text "エラーが発生したため ユーザー は保存されませんでした。"
  end
end
