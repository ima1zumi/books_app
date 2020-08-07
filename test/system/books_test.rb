# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    signin_user("john@example.com", "password")
  end

  test "show book list" do
    visit "/"
    assert_selector "h1", text: "本一覧"
  end

  test "create book" do
    visit "ja/books/new"
    assert_selector "h1", text: "新規登録"
    fill_in "タイトル", with: "順列都市"
    fill_in "メモ", with: "SF"
    fill_in "著者", with: "グレッグ・イーガン"
    attach_file "画像", Rails.root.join('app/assets/images/shigoto_zaitaku_cat_woman.png')
    click_on "登録する"

    assert_text "新規作成しました！"
  end

  test "create and update book" do
    visit "ja/books/new"
    assert_selector "h1", text: "新規登録"
    fill_in "タイトル", with: "紙の動物園"
    fill_in "メモ", with: "中国現代SF"
    fill_in "著者", with: "ケン・リュウ"
    click_on "登録する"

    assert_text "新規作成しました！"
    click_on "編集"

    assert_selector "h1", text: "編集"
    fill_in "タイトル", with: "ソラリス"
    fill_in "メモ", with: "ファーストコンタクト"
    fill_in "著者", with: "スタニスワフ・レム"
    click_on "更新する"

    assert_text "更新しました！"
  end

  test "destroy book" do
    id = books(:book_2).id
    visit "ja/books/#{id}"

    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "削除しました！"
    assert_not Book.exists?(id)
  end
end
