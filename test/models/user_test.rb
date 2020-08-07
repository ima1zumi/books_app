# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should follow and unfollow a user" do
    john = users(:user_1)
    alice = users(:user_3)
    assert_not john.following?(alice)
    john.follow(alice)
    assert john.following?(alice)
    assert alice.followers.include?(john)
    john.unfollow(alice)
    assert_not john.following?(alice)
  end

  test "#update_without_current_password" do
    john = User.new(id: 1, email: "john@example.com", name: "ジョン・ウィック")
    params = {
      "zipcode" => "123-4567",
      "address" => "London",
      "profile" => "キアヌ・リーヴス"
    }
    john.update_without_current_password(params)
    assert_equal john.zipcode, "123-4567"
    assert_equal john.address, "London"
    assert_equal john.profile, "キアヌ・リーヴス"
  end

  test "#feed" do
    john = users(:user_1)
    alice = users(:user_3)
    john.follow(alice)
    Book.new(title: "不思議の国のアリス", user_id: alice.id).save
    assert john.feed.find_by(title: "不思議の国のアリス", user_id: alice.id)
  end

  test "#find_for_github_oauth" do
    auth = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "321654",
      info: {
        name: "bob smith",
        nickname: "bobsmith",
        email: "example@example.com"},
    })
    user = User.find_for_github_oauth(auth)
    assert user.valid?
  end
end
