require 'spec_helper'

feature "blog_index" do
  # 一般ユーザとして
  context "as a nomal user" do
    # blogを閲覧する
    scenario "view a blog_index by nomal user" do
      @blog_indeices=FactoryGirl.create(:blog_index)
      visit "/blog_indices"
      expect(page).to have_content("記事一覧")
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

  # 管理ユーザとして
  context "as a admin user" do
    # blog_indexを閲覧する
    scenario "view a blog_index" do
      @blog_indeices=FactoryGirl.create(:blog_index)
      visit "/blog_indices"
      expect(page).to have_content("記事一覧")
      #facebookがある
      #更新ボタンがある
      #削除ボタンがある
      #投稿ボタンがある

      #blog詳細へ移動
      find_by_id('blog_title').click
      expect(page).to have_content("記事詳細")

      #facebookがある
      #更新ボタンがある
      #削除ボタンがある
      #投稿ボタンがある

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
end
