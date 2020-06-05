# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    @comments = @commentable.comments.all
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to [@commentable, :comments], notice: t("directory.flash.new")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to [@commentable, :comments], notice: t("directory.flash.update")
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to [@commentable, :comments], notice: t("directory.flash.destroy")
  end

  private
    def set_comment
      @comment = @commentable.comments.find_by(id: params[:id], user_id: current_user.id)
    end

    def comment_params
      params.require(:comment).permit(:description, :user_id, :commentable)
    end
end
