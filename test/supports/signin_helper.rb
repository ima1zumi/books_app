# frozen_string_literal: true

module SigninHelper
  def signin_user(email, password)
    visit "ja/users/sign_in"
    fill_in("user[email]", with: email)
    fill_in("user[password]", with: password)
    click_button "ログイン"
  end

  def signout
    visit "ja/users/sign_out"
  end
end
