# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :ensure_login_user, only: [:new, :create]
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @reports = Report.all
  end

  def show
  end

  def new
    @report = Report.new
  end

  def edit
    @report = current_user.reports.find(params[:id])
  end

  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id

    if @report.save
      redirect_to @report, notice: t("directory.flash.new")
    else
      render :new
    end
  end

  def update
    @report = current_user.reports.find(params[:id])

    if @report.update(report_params)
      redirect_to @report, notice: t("directory.flash.update")
    else
      render :edit
    end
  end

  def destroy
    @report = current_user.reports.find(params[:id])

    @report.destroy
    redirect_to reports_url, notice: t("directory.flash.destroy")
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:title, :description, :user_id)
    end
end
