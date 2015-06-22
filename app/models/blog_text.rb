class BlogText < ActiveRecord::Base
  #blog_iindexと多対１の関係
  belongs_to :blog_index
  #valudate textは必須
  validates :text, presence: true
  def self.find_by_blog_index_id(blog_index_id)
    blog_images=BlogText.select(:id,:blog_index_id,:text_id,:text).where(blog_index_id: blog_index_id).to_a
  end

  def self.fild_by_detail(id)
    blog_texts=BlogText.where(id: id).to_a
  end

  def self.update_text(id, text)
    BlogText.where(id: id).update_all(text: text)
  end
end
