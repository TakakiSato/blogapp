class CreateBlogIndices < ActiveRecord::Migration
  def change
    create_table :blog_indices do |t|
      #t.column :id, :integer, :null => false
      t.column :title, :string, :null => false
      t.column :contents_id, :integer, :null => false
      t.column :detail_id, :integer, :null => false
      t.timestamps
    end
  end
end
