class IndicesConstChange2 < ActiveRecord::Migration
  def change
   change_column_null :blog_indices, :title, true 
   change_column_null :blog_indices, :num_of_image, true
   change_column_null :blog_indices, :num_of_text, true
  end
end
