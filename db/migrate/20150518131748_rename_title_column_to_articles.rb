class RenameTitleColumnToArticles < ActiveRecord::Migration
  def change
   rename_column :blog_images, :index_id, :blog_index_id
   rename_column :blog_texts, :index_id, :blog_index_id
  end
end
