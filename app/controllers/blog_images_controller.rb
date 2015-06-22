class BlogImagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  #before_action :authenticate_blog_user!, only: [:new, :create]
  def create()
    begin
      blog_index_id=params[:blog_index_id]
      blog_image=params[:blog_images]

      loger("create", blog_index_id, "blog_index_id","start")
      #image格納パス生成
      @dir_path = "/images/#{Time.now.strftime("%Y")}/#{blog_index_id}/"
      #フォルダがなければ作成する。
      Dir::mkdir("./public#{@dir_path}",0777) unless FileTest.exist?("./public#{@dir_path}")

      #image_idの最大値を取得
      image_id=BlogImage.find_by_max_blog_index_id(blog_index_id)
      if image_id.blank?
      image_id=0
      else
      image_id = image_id+1
      end
      logger.debug(image_id)

      #Fileの実態を登録
      File.binwrite("./public#{@dir_path}/#{image_id}.jpg", blog_image.read)
      #File.chmod(0777, "#{@dir_path}/#{image_id}.jpg")
      #Fileのパスを登録
      BlogImage.create(:blog_index_id=>blog_index_id,:image_id=>image_id ,:image=>"#{@dir_path}/#{image_id}.jpg")
      logger.debug("image_id #{image_id}を登録しました。")
      #end
      logger.debug (image_id)
      #logger.debug (blog_image.read)
      logger.debug ("#{@dir_path}/#{image_id}.jpg")
      loger("create", blog_index_id, "blog_index_id","end")
      render :nothing => true
    rescue => e
      p e
    end
  end

  def index(blog_index_ids)
    begin
      loger("index", blog_index_ids, "blog_index_ids","start")
      #DBから値の取得
      @blog_image_array=BlogImage.find_by_blog_index_id(blog_index_ids)
      loger("index", blog_index_ids, "blog_index_ids","end")
      logger.debug(@blog_image_array)
      return @blog_image_array
    rescue => e
      p e
    end
  end

  def show(blog_index_id)
    begin
      loger("show", blog_index_id, "blog_index_id","start")
      #DBから値の取得
      @blog_image_array=BlogImage.find_by_blog_index_id(blog_index_id)
      loger("show", blog_index_id, "blog_index_id","end")
      return @blog_image_array
    rescue => e
      p e
    end
  end

  def update(id,image)
    begin
      loger("update", id, "id","start")
      #DBから値の取得
      @blog_image_array=BlogImage.update_image(id,image)
      loger("update", id, "id","end")
      return @blog_image_array

    rescue => e
      p e
    end
  end

  def new
    blog_images=[]
    blog_index_id=params[:blog_index_id]
    blog_images.push(params[:blog_images])
    logger.debug(params[:blog_index_id])
    logger.debug(params[:index_images])
  end

  def loger(method, blog_index_id, object,timing)
    logger.debug("#{Time.now} blog_images_controler #{method} #{timing}!!")
    logger.debug("method:#{method} #{object}:#{blog_index_id}")
  end

end
