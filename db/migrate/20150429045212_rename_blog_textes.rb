class RenameBlogTextes < ActiveRecord::Migration
  def change
    rename_table :blog_textes, :blog_texts #この行を追加！
  end
end
