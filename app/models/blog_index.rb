class BlogIndex < ActiveRecord::Base
  #blog_imagesと1対多の関係
  has_many :blog_images, :dependent => :delete_all
  #blog_textssと1対多の関係
  has_many :blog_texts, :dependent => :delete_all
  accepts_nested_attributes_for :blog_images, allow_destroy: true
  accepts_nested_attributes_for :blog_texts, allow_destroy: true
  #valudate titleは必須
  #validates :title, presence: true
  def self.select_id()
    blog_indices=BlogIndex.select(:id).where("title IS NOT NULL").order("id DESC").to_a
  end

  def self.select_title()
    blog_indices=BlogIndex.select(:id,:title).where("title IS NOT NULL").order("id DESC").to_a
  end

  def self.fild_by_detail(id)
    blog_indices=BlogIndex.where(id: id).to_a
  end

  def self.update_title(id, title)
    update_num=BlogIndex.where(id: id).update_all(title: title)
    return update_num
  end

  def self.update_detail(id, title,num_of_image,num_of_text)
    update_detail=BlogIndex.where(id: id).update_all(title:title,num_of_image:num_of_image ,num_of_text:num_of_text)
    return update_detail
  end

end
