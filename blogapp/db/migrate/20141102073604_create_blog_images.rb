class CreateBlogImages < ActiveRecord::Migration
  def change
    create_table :blog_images do |t|
      t.integer :contents_id
      t.integer :detail_id
      t.binary :image, :limit => 2.gigabyte
      t.timestamps
    end

    create_table :blog_textes do |t|
      t.integer :contents_id
      t.integer :detail_id
      t.string :text
      t.timestamps
    end
  end
end
