class ChangeBlogTextes < ActiveRecord::Migration
  def change
     change_column :blog_textes, :text, :text, :limit => 4294967295
  end
end
