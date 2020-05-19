# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = current_user.feed.page(params[:page])
  end

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end

  def destroy
    user = Friendship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
end
