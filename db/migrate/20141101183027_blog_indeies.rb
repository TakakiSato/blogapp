class BlogIndeies < ActiveRecord::Migration
  def up
    add_column :blog_indices,:title,:string,:null=>false
    add_column :blog_indices,:contents_id,:integer,:null=>false
    add_column :blog_indices,:detail_id,:integer,:null=>false
  end
end
