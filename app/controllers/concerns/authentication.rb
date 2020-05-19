# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  def ensure_login_user
    unless user_signed_in?
      flash[:notice] = "ログインしてください。"
      redirect_to :root
    end
  end
end
