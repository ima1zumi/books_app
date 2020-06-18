# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  before_action :set_book
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    @comments = @book.comments.all
  end

  def new
    @comment = @book.comments.new
  end

  def create
    @comment = @book.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to [@book, :comments], notice: t("directory.flash.new")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to [@book, :comments], notice: t("directory.flash.update")
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to [@book, :comments], notice: t("directory.flash.destroy")
  end

  private
    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_comment
      @comment = @book.comments.find_by(id: params[:id], user_id: current_user.id)
    end

    def comment_params
      params.require(:comment).permit(:description, :user_id, :book)
    end
end
