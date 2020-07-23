# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "sign in" do
    visit "ja/users/sign_in"

    fill_in "メールアドレス", with: "john@example.com"
    fill_in "パスワード", with: "password"
    click_on "ログイン", match: :first

    assert_text "ログインしました。"
  end

  test "sign out" do
    signin_user("john@example.com", "password")
    visit "/"
    click_on "ログアウト"

    assert_text "ログアウトしました。"
  end

  test "visiting an user" do
    signin_user("john@example.com", "password")
    visit "ja/users/#{users(:user_1).id}"
    assert_selector "h1", text: "ユーザー情報"
  end

  test "create user" do
    visit "/"
    click_on "新規登録"

    fill_in "メールアドレス", with: "bob@example.com"
    fill_in "名前", with: "Bob"
    fill_in "パスワード", with: "password"
    fill_in "パスワード（確認用）", with: "password"
    click_on "アカウント登録"

    assert_text "アカウント登録が完了しました。"
  end

  test "updating an user" do
    signin_user("john@example.com", "password")
    visit "ja/users/#{users(:user_1).id}"
    click_on "プロフィール編集"

    assert has_field?("メールアドレス", with: "john@example.com")
    assert has_field?("名前", with: "John Wick")

    fill_in "郵便番号", with: "123-4567"
    fill_in "住所", with: "40 Example Street London"
    fill_in "自己紹介", with: "妻と犬が好き"
    click_on "更新"

    assert_text "アカウント情報を変更しました。"
  end

  test "updating an user failed" do
    signin_user("john@example.com", "password")
    visit "ja/users/#{users(:user_1).id}"
    click_on "プロフィール編集"

    fill_in "名前", with: "a"*31
    click_on "更新"

    assert_text "エラーが発生したため ユーザー は保存されませんでした。"
  end

  test "destroy an user" do
    id = users(:user_2).id
    signin_user("taikai@example.com", "password")

    visit "ja/users/edit"
    page.accept_confirm do
      click_on "アカウント削除"
    end

    assert_text "アカウントを削除しました。またのご利用をお待ちしております。"
    assert_not User.exists?(id)
  end
end
