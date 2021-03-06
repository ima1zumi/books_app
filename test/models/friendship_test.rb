# frozen_string_literal: true

require "test_helper"

class FriendshipTest < ActiveSupport::TestCase
  setup do
    @friendship = Friendship.new(follower_id: users(:user_1).id, followed_id: users(:user_3).id)
  end

  test "should be valid" do
    assert @friendship.valid?
  end

  test "should require a follower_id" do
    @friendship.follower_id = nil
    assert_not @friendship.valid?
  end

  test "should require a followed_id" do
    @friendship.followed_id = nil
    assert_not @friendship.valid?
  end
end
