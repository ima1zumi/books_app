# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :ensure_login_user, only: [:new, :create]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.page(params[:page])
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
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
  # PATCH/PUT /books/1.json
  def update
    @book.user_id = current_user.id
    if @book.update(book_params)
      redirect_to @book, notice: t("directory.flash.update")
    else
      render :edit
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
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

    def ensure_login_user
      unless user_signed_in?
        flash[:notice] = "ログインしてください。"
        redirect_to :root
      end
    end

    def ensure_correct_user
      @book = Book.find_by(id: params[:id])
      if !user_signed_in? || @book.user_id != current_user.id
        flash[:notice] = "権限がありません"
        redirect_to @book
      end
    end
end
