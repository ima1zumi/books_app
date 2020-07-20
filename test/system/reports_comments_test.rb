# frozen_string_literal: true

require "application_system_test_case"

class ReportsCommentsTest < ApplicationSystemTestCase
  setup do
    signin_user("john@example.com", "password")
  end

  test "show comments list" do
    visit "ja/reports/#{reports(:report_1).id}/comments"
    assert_selector "h1", text: "コメント一覧"
  end

  test "create comment" do
    visit "ja/reports/#{reports(:report_1).id}/comments/new"
    assert_selector "h1", text: "新規登録"
    fill_in "本文", with: "面白かったです。"
    click_on "登録する"

    assert_text "新規作成しました！"
  end

  test "create and update comment" do
    visit "ja/reports/#{reports(:report_1).id}/comments/new"
    assert_selector "h1", text: "新規登録"
    fill_in "本文", with: "勉強になりました。"
    click_on "登録する"

    assert_text "新規作成しました！"
    click_on "編集", match: :first

    assert_selector "h1", text: "編集"
    fill_in "本文", with: "勉強になりました！！！"
    click_on "更新する"

    assert_text "更新しました！"
  end

  test "destroy comment" do
    visit "ja/reports"
    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "削除しました！"
  end
end
