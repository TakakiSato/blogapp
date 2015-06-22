class IndicesConstChange < ActiveRecord::Migration
  def change
   change_column_null :blog_indices, :title, false
   change_column_null :blog_indices, :num_of_image, false
   change_column_null :blog_indices, :num_of_text, false
  end
end
