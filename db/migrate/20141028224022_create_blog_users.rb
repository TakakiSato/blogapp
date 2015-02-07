class CreateBlogUsers < ActiveRecord::Migration
  def change
    create_table :blog_users do |t|

      t.timestamps
    end
  end
end
