class DropTableBlogUsers < ActiveRecord::Migration
  def change
	drop_table :blog_users
  end
end
