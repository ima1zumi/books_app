# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  before_action :set_report
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    @comments = @report.comments.all
  end

  def new
    @comment = @report.comments.new
  end

  def create
    @comment = @report.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to [@report, :comments], notice: t("directory.flash.new")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to [@report, :comments], notice: t("directory.flash.update")
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to [@report, :comments], notice: t("directory.flash.destroy")
  end

  private
    def set_report
      @report = Report.find(params[:report_id])
    end

    def set_comment
      @comment = @report.comments.find_by(id: params[:id], user_id: current_user.id)
    end

    def comment_params
      params.require(:comment).permit(:description, :user_id, :report)
    end
end
