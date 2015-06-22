class BlogTextsController < ApplicationController
  #before_action :authenticate_blog_user!, only: [:new, :create]
  def create(blog_texts , blog_index_id)
    begin
      loger("create", blog_index_id, "blog_index_id","start")
      #ハッシュを配列に変換する
      #p blog_texts.values
      @text_array=blog_texts.values
      @blog_texts=[]
      #blog_textesのnew呼び出す。
      for text_id in 0..@text_array.size - 1 do
        BlogText.create(:blog_index_id=>blog_index_id,:text_id=>text_id ,:text=>@text_array[text_id])
        logger.debug("#{@text_array.size}個中 #{text_id + 1}個目を登録しました。")
      end
      loger("create", blog_index_id, "blog_index_id","end")
    rescue => e
      p e
    end
  end

  def index(blog_index_ids)
    begin
      loger("index", blog_index_ids, "blog_index_ids","start")
      #DBから値の取得
      @blog_text_array=BlogText.find_by_blog_index_id(blog_index_ids)
      loger("index", blog_index_ids, "blog_index_ids","end")
      return @blog_text_array
    rescue => e
      p e
    end
  end

  def show(blog_index_id)
    begin
      loger("show", blog_index_id, "blog_index_id","start")
      #DBから値の取得
      @blog_text_array=BlogText.find_by_blog_index_id(blog_index_id)
      loger("show", blog_index_id, "blog_index_id","end")
      return @blog_text_array
    rescue => e
      p e
    end
  end

  def update(id,text)
    begin
      loger("update", id, "id","start")
      #DBから値の取得
      @blog_text_array=BlogText.update_text(id,text)
      return @blog_text_array
      loger("update", id, "id","end")
    rescue => e
      p e
    end
  end

  def loger(method, blog_index_id, object,timing)
    logger.debug("#{Time.now} blog_texts_controler #{method} #{timing}!!")
    logger.debug("method:#{method} #{object}:#{blog_index_id}")
  end

end
