class BlogIndex < ActiveRecord::Base
  has_many :blog_images
  has_many :blog_textes
  accepts_nested_attributes_for :blog_images, allow_destroy: true
  accepts_nested_attributes_for :blog_textes, allow_destroy: true
  #blogのタイトルとコンテンツをまとめて取得、最新5つの更新を取得
  #blog_imagesとblog_indicesをright join
  #blog_textesとblog_indicesをright join
  #それぞれの結果をUNIONさせる。
  ##<BlogIndex id: 数字, created_at: 日付, updated_at: 日付", title: 文字列>
  #の形式で、画像、個記事分のレコードが取得される。
  def self.find_by_indices_detail
    @blog_indices=BlogIndex.find_by_sql("
    (select
    INX.id,
    INX.created_at,
    INX.updated_at,
    INX.title,
    INX.contents_id as txt_array_max,
    INX.detail_id as img_array_max,
    IMG.detail_id as contents_num,
    IMG.image as img,
    '' as txt
    from blog_images as IMG
    right join
    (select blog_indices.*
    from
    blog_indices
    order by
    updated_at asc
    limit 5) as INX
    on INX.id=IMG.contents_id)
    union
    (select
    INX.id,
    INX.created_at,
    INX.updated_at,
    INX.title,
    INX.contents_id,
    INX.detail_id,
    TXT.detail_id,
    '',
    TXT.text
    from blog_textes as TXT
    right join
    (select blog_indices.*
    from
    blog_indices
    order by
    updated_at asc
    limit 5) as INX
    on INX.id=TXT.contents_id);
    ")
  end

  def self.find_by_index_detail(id)
    @blog_detail=BlogIndex.find_by_sql(["
    (select
    INX.id,
    INX.created_at,
    INX.updated_at,
    INX.title,
    INX.contents_id as txt_array_max,
    INX.detail_id as img_array_max,
    IMG.detail_id as contents_num,
    IMG.image as img,
    '' as txt
    from blog_images as IMG
    right join
    (select blog_indices.*
    from
    blog_indices
    where id = :id
    order by
    updated_at asc
    limit 5) as INX
    on INX.id=IMG.contents_id)
    union
    (select
    INX.id,
    INX.created_at,
    INX.updated_at,
    INX.title,
    INX.contents_id,
    INX.detail_id,
    TXT.detail_id,
    '',
    TXT.text
    from blog_textes as TXT
    right join
    (select blog_indices.*
    from
    blog_indices
    where id = :id
    order by
    updated_at asc
    limit 5) as INX
    on INX.id=TXT.contents_id);
    ",{:id=>id}])
  end
end
