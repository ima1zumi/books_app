# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :ensure_login_user, only: [:new, :create]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  def index
    @books = Book.page(params[:page])
  end

  # GET /books/1
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    @book = current_user.books.find(params[:id])
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to @book, notice: t("directory.flash.new")
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    @book = current_user.books.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: t("directory.flash.update")
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    @book = current_user.books.find(params[:id]).destroy
    @book.destroy
    redirect_to books_url, notice: t("directory.flash.destroy")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end
end
