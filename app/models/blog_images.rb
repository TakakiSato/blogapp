class BlogImages < ActiveRecord::Base
  has_many :blog_images
  has_many :blog_textes
  accepts_nested_attributes_for :blog_images, allow_destroy: true
  accepts_nested_attributes_for :blog_textes, allow_destroy: true
end
