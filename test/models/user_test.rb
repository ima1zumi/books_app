# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should follow and unfollow a user" do
    john = users(:one)
    hoge  = users(:two)
    assert_not john.following?(hoge)
    john.follow(hoge)
    assert john.following?(hoge)
    assert hoge.followers.include?(john)
    john.unfollow(hoge)
    assert_not john.following?(hoge)
  end
end
