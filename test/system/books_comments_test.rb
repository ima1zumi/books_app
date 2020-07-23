# frozen_string_literal: true

require "application_system_test_case"

class BooksCommentsTest < ApplicationSystemTestCase
  setup do
    signin_user("john@example.com", "password")
  end

  test "show comments list" do
    visit "ja/books/#{books(:book_1).id}/comments"
    assert_selector "h1", text: "コメント一覧"
  end

  test "create comment" do
    visit "ja/books/#{books(:book_1).id}/comments/new"
    assert_selector "h1", text: "新規登録"
    fill_in "本文", with: "面白かったです。"
    click_on "登録する"

    assert_text "新規作成しました！"
  end

  test "create and update comment" do
    visit "ja/books/#{books(:book_1).id}/comments/new"
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
    id = comments(:book_comment_2).id
    visit "ja/books/#{comments(:book_comment_2).commentable.id}/comments/#{id}/edit"

    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "削除しました！"
    assert_not Comment.exists?(id)
  end
end
