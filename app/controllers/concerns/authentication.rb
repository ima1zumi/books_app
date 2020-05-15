# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

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
