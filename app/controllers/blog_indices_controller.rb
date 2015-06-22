class BlogIndicesController < ApplicationController
  # ユーザがログインしていないとにアクセスできないアクション
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy ]
  def new
    commonLog("new", "blog_index.id", "all","start")
    #blog_indexのidをのみ登録する。
    @blog_index=BlogIndex.create()
    #blog_text初期化
    @result_blog_texts=Array.new()
    @result_blog_texts.push(BlogText.new(text:""))
    #form_tagに埋め込むコミット先のURLを指定
    @path="/blog_indices"
    #form_tagに埋め込むmethodを指定
    @method="post"
    logger.debug(@result_blog_texts)
    logger.debug(@blog_index)
    commonLog("new", "blog_index.id", "all","end")
  end

  def edit
    commonLog("edit", "blog_index.id", params[:id] ,"start")
    #指定のidのtitleを取得する。
    @blog_index=BlogIndex.fild_by_detail(params[:id])[0]
    @result_blog_index_id=BlogIndex.fild_by_detail(params[:id])[0]
    #blog_idに紐づくtext,imageを取得する。
    commonSelect( @result_blog_index_id)
    #form_tagに埋め込むコミット先のURLを指定
    
    @path="/blog_indices/#{@result_blog_index_id.id}"
    #form_tagに埋め込むmethodを指定
    @method="put"
    logger.debug( @result_blog_texts)
    logger.debug( @result_blog_images)
    commonLog("edit", "blog_index.id", params[:id] ,"end")
  end

  def index
    commonLog("index", "blog_index.id", "all","start")
    #blog_indexのidをすべて取得する。
    @result_blog_index_title=BlogIndex.select_title()
    @result_blog_index_id=BlogIndex.select_id()
    #blog_idに紐づくtext,imageを取得する。
    logger.debug(@result_blog_index_id)
    commonSelect(@result_blog_index_id)
    commonLog("index", "blog_index.id", "all","end")
  end

  def show
    commonLog("show", "blog_index.id", params[:id],"start")
    #指定のidのtitleを取得する。
    @result_blog_index_id=BlogIndex.fild_by_detail(params[:id])
    #blog_idに紐づくtext,imageを取得する。
    commonSelect( @result_blog_index_id)
    logger.debug( @result_blog_index_id)
    logger.debug( @result_blog_texts)
    logger.debug( @result_blog_images)

    commonLog("show", "blog_index.id", params[:id],"end")
  end

  def create
    #トランザクション開始
    begin
      commonLog("create", "blog_index.id", "new","start")
      #paramの取得
      blog_title=params[:blog_title]
      blog_texts=params[:blog_texts]
      blog_index_id=params[:blog_index_id]

      #blog_images=params[:counter]
      BlogIndex.transaction do
      #登録された画像の個数
        blog_images_controller=BlogImagesController.new
        blog_images=blog_images_controller.show(blog_index_id)

        #blog_indexを登録する。
        @blog_index_result = BlogIndex.update_detail(blog_index_id,blog_title,blog_images.size ,blog_texts.size)

        #blogtextes_controllerのcreateを呼び出す。
        blog_texts_controller=BlogTextsController.new
        blog_texts_controller.create(blog_texts,blog_index_id)
      end
      commonLog("create", "blog_index.id", "new","end")
    end
  rescue => e
    p e
  ensure
    redirect_to blog_indices_path

    end

  def update
    #トランザクション開始
    begin
      commonLog("update", "blog_index.id", params[:id] ,"start")
      BlogIndex.transaction do
      #paramの取得
        id=params[:id]
        blog_title=params[:blog_title]
        blog_texts=params[:blog_texts]

        #blog_titleをアップデートする。
        @title_update_num=BlogIndex.update_title(id,blog_title)

        #blogtextes_controllerのcreateを呼び出す。
        blog_texts_controller=BlogTextsController.new
        @text_update_num=blog_texts_controller.update(id,blog_texts)

      end
      commonLog("edit", "blog_index.id", params[:id] ,"end")
    end
  rescue => e
    p e
  ensure
    redirect_to blog_indices_path
    end

  def destroy
    #トランザクション開始
    begin
      commonLog("destroy", "blog_index.id", params[:id] ,"start")
      BlogIndex.transaction do
      #DBから値の取得
        @dl_result_blog_index=BlogIndex.destroy_all(id:params[:id])
      end
      commonLog("destroy", "blog_index.id", params[:id] ,"end")
    #redirect_to :back
    end
  rescue => e
    p e
  ensure
    redirect_to blog_indices_path
    end

  def commonSelect(result_blog_index_id)
    #blogtextes_controllerのindexを呼び出す。
    blog_texts_controller=BlogTextsController.new
    @result_blog_texts=blog_texts_controller.index(@result_blog_index_id)
    #blogimages_controllerのindexを呼び出す。
    blog_images_controller=BlogImagesController.new
    @result_blog_images=blog_images_controller.index(@result_blog_index_id)
  end

  def commonLog(method, index_id, object,timing)
    logger.debug("#{Time.now} blog_indices_controler #{method} #{timing}!!")
    logger.debug("method:#{method} #{object}:#{index_id}")
  end
end
