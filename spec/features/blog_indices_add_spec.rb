require 'spec_helper'

feature "blog_index_add" do
  # 管理ユーザとして
  context "as a admin user" do
    # blogを閲覧する
    scenario "view a blog_index by admin user" do
      #topページにアクセス
      visit "/blog_indices"
      #新規投稿リンクを選択
      expect(page).to have_content("記事一覧")
      find_by_id('new_blog_index').click
      expect(page).to have_content("記事投稿")



      #facebookがある
      #更新ボタンがない
      #削除ボタンがない
      #投稿ボタンがない

      #blog詳細へ移動
      puts source

      find_by_id('blog_title').click
      expect(page).to have_content("記事詳細")
      #facebookがある
      #更新ボタンがない
      #削除ボタンがない
      #投稿ボタンがない

      #戻るボタンを押す
      find_by_id('blog_indeices').click
      expect(page).to have_content("記事一覧")
      #blog詳細へ移動
      find_by_id('blog_title').click
      expect(page).to have_content("記事詳細")

      #前の記事へ
      #      find_by_id('blog_prov').click
      #      expect(page).to have_content("記事詳細")

      #次の記事へ
      #      find_by_id('blog_next').click
      #      expect(page).to have_content("記事詳細")
    end
  end
