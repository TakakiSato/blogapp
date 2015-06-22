class RenameRowName < ActiveRecord::Migration
  def change
    rename_column :blog_indices, :contents_id, :num_of_image
    rename_column :blog_indices, :detail_id, :num_of_text
    rename_column :blog_images, :contents_id, :index_id
    rename_column :blog_images, :detail_id, :image_id
    rename_column :blog_texts, :contents_id, :index_id
    rename_column :blog_texts, :detail_id, :text_id
  end
end
