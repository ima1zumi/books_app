# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    signin_user("john@example.com", "password")
  end

  test "show report list" do
    visit "ja/reports"
    assert_selector "h1", text: "日報一覧"
  end

  test "create report" do
    visit "ja/reports/new"
    assert_selector "h1", text: "新規登録"
    fill_in "タイトル", with: "初めての日報"
    fill_in "本文", with: "よろしくお願いします"
    click_on "登録する"
    assert_text "新規作成しました！"
  end

  test "create and update report" do
    visit "ja/reports/new"
    assert_selector "h1", text: "新規登録"
    fill_in "タイトル", with: "はじめてのにっぽう"
    fill_in "本文", with: "よろしくおねがいします"
    click_on "登録する"

    assert_text "新規作成しました！"
    click_on "編集"

    assert_selector "h1", text: "編集"
    fill_in "タイトル", with: "初めての日報"
    fill_in "本文", with: "よろしくお願いします"
    click_on "更新する"

    assert_text "更新しました！"
  end

  test "destroy report" do
    id = reports(:report_2).id
    visit "ja/reports/#{id}"

    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "削除しました！"
    assert_not Report.exists?(id)
  end
end
