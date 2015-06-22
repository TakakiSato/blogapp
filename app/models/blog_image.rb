class BlogImage < ActiveRecord::Base
  #blog_iindicesと多対１の関係
  belongs_to :blog_index
  #valudate imageは必須
  validates :image, presence: true
  def self.find_by_blog_index_id(blog_index_id)
    blog_images=BlogImage.select(:id,:blog_index_id,:image_id,:image).where(blog_index_id: blog_index_id).to_a
  end

  def self.find_by_max_blog_index_id(blog_index_id)
    blog_images=BlogImage.select(:image_id).where(blog_index_id: blog_index_id).maximum(:image_id)
  end


  def self.fild_by_detail(id)
    blog_images=BlogImage.where(id: id).to_a
  end

  def self.update_image(id, image)
    BlogImage.where(id: id).update_all(image: image)
  end
end
