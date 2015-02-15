class BlogIndicesController < ApplicationController
  before_action :set_blog_index, only: [:show, :edit, :update, :destroy]

  # GET /blog_indices
  # GET /blog_indices.json
  def index
    #----------------------------------------
    #DBから値の取得
    @blog_indices=BlogIndex.find_by_indices_detail()
    blog_data_create()
  end

  # GET /blog_indices/1
  # GET /blog_indices/1.json
  def show
    @blog_indices=BlogIndex.find_by_index_detail(params[:id])
    blog_data_create()
  end

  # GET /blog_indices/new
  def new
    @blog_index = BlogIndex.new
  end

  # GET /blog_indices/1/edit
  def edit
  end

  # POST /blog_indices
  # POST /blog_indices.json
  def create
    #@blog_index = BlogIndex.new(blog_index_params)
    #formのblog_indices(中身はタイトル)を配列で取得
    @blog_title=params[:blog_indices]
    #formのblog_textesを配列で取得
    @texts_array=params[:blog_textes]
    #formのblog_imagesを配列で取得
    @images_array=params[:blog_images]
    #@images_array2=params[:blog_images][:img_2].read
    #texts_arrayのkeyの最大値取得
    @texts_array_max = @texts_array.keys.map {|item| item.to_i }.max
    #images_arrayのkeyの最大値取得
    @images_array_max = @images_array.keys.map {|item| item.to_i }.max
    #images_array_maxと@texts_array_maxの最大値を取得
    @array_max_sum = @texts_array_max + @images_array_max
    #logger.debug(@blog_title)
    #logger.debug(@texts_array)
    #logger.debug(@images_array)
    #logger.debug(@images_array2)
    #logger.debug(@texts_array_max)
    #logger.debug(@images_array_max)
    #logger.debug(@texts_array_max + @images_array_max)
    #logger.debug(@texts_array["1"])
    #logger.debug(@blog_title["title"])

    #トランザクション開始
    begin
      BlogIndex.transaction do
        #blog_indicesをコミット
        #title contents_id（image)の最大値 details_id(title)最大値をコミット
        @blog_index = BlogIndex.create(:title => @blog_title["title"],:contents_id => @images_array_max,:detail_id => @array_max_sum)
        logger.debug(@blog_index.id)
        #texts_arrayをひとつづつコミット(text_array_max分ループ)
        #contents_idにblog_indexのidを投入
        #detail_idは_formに記載されている番号
        for @text in @texts_array do
          @blog_text = BlogTextes.create(:contents_id=>@blog_index.id,:detail_id=>@text[0] ,:text=>@text[1])
          logger.debug(@text[0])
        end
        #images_arrayをひとつづつコミット(image_array_max分ループ)
        #contents_idにblog_indexのidを投入
        #detail_idは_formに記載されている番号
        for @image in @images_array do
          @dir_path ="./public/images/#{@blog_index.created_at.strftime("%Y")}/#{@blog_index.id}/"
          @file_path = @dir_path + @image[0] + '.jpg'
          @reg_path = "#{@blog_index.created_at.strftime("%Y")}/#{@blog_index.id}/" + @image[0] + '.jpg'
          logger.debug(@dir_path)
          logger.debug(@image)
          logger.debug(@image[0])
          @blog_images = BlogImages.create(:contents_id=>@blog_index.id,:detail_id=>@image[0] ,:image=>@reg_path )

          #ファイルを格納するディレクトリを作成する。
          logger.debug(@dir_path)
          Dir::mkdir(@dir_path,0777) unless FileTest.exist?(@dir_path)
          #画像ファイルを書き込む
          File.binwrite(@file_path, @image[1].read)
          File.chmod(0444, @file_path)
          logger.debug(@file_path)
        end
      end
    end
    #ほんとはshowへ飛ばしたい。
    respond_to do |format|
      format.html { redirect_to :action=>"index", notice: 'task_master was successfully created.' }
      format.json { render :index, status: :created, location: @blog_index }
    end
  end

  # PATCH/PUT /blog_indices/1
  # PATCH/PUT /blog_indices/1.json
  def update
    respond_to do |format|
      if @blog_index.update(blog_index_params)
        format.html { redirect_to @blog_index, notice: 'Blog index was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog_index }
      else
        format.html { render :edit }
        format.json { render json: @blog_index.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_indices/1
  # DELETE /blog_indices/1.json
  def destroy
    @blog_index.destroy
    respond_to do |format|
      format.html { redirect_to blog_indices_url, notice: 'Blog index was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_blog_index
    @blog_index = BlogIndex.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_index_params
    params.require(:blog_index).permit(:title, :blog_text => [:id, :contents_id, :detail_id, :text], :blog_image => [:id, :contents_id, :detail_id, :image])
  end

  def blog_data_create()
    logger.debug("DBから取得した値は#{@blog_indices}")
    #-----------------------------------------
    #blog記事ごとに変数を分ける。
    #取得したblogIDを取得
    #[id, id, id]
    #の形式で各記事のid(数字)を取得
    @blog_id_array = Array.new
    @blog_indices.each do |blog_index|
      @blog_id_array.push(blog_index.id)
    end
    @blog_id_array = @blog_id_array.uniq
    logger.debug("対象のblog_idは#{@blog_id_array}")
    #------------------------------------------
    #blog_idごとにハッシュをにタイトル、id,日付、コンテンツをつめる。
    #対象の記事数分ループさせる
    @blog_id_array.each do |blog_id|
      #blog_idごとのハッシュをnewする。コンテンツの総個数を初期値0で設定
      eval("@blog_id_#{blog_id} = Hash['max_content_num' => 0,'min_img_num' => 999999]")
      eval("@blog_id_#{blog_id}_txt_all = String.new")
      @blog_indices.each do |blog_index|
        if blog_id == blog_index.id then
          #共通データを配列に投入
          eval("@blog_id_#{blog_id}").store("id",blog_index.id)
          eval("@blog_id_#{blog_id}").store("created_at",blog_index.created_at)
          eval("@blog_id_#{blog_id}").store("updated_at",blog_index.updated_at)
          eval("@blog_id_#{blog_id}").store("title",blog_index.title)
          #コンテンツ分ハッシュに追加.
          if blog_index.txt.blank? then
            eval("@blog_id_#{blog_id}.store('#{blog_index.contents_num}',blog_index.img)")
            #記事内の最初のimgを取得
            @comp_img=[eval("@blog_id_#{blog_id}")['min_img_num'],blog_index.contents_num]
            eval("@blog_id_#{blog_id}").store('min_img_num',@comp_img.min)
          else
            eval("@blog_id_#{blog_id}.store('#{blog_index.contents_num}',blog_index.txt)")
            #全文取得
            eval("@blog_id_#{blog_id}_txt_all") << blog_index.txt
          end
          #content_numの最大値を投入
          @comp=[eval("@blog_id_#{blog_id}")['max_content_num'],blog_index.contents_num]
          eval("@blog_id_#{blog_id}").store('max_content_num',@comp.max)
        end
      end
      #txt_allをtrim
      eval("@blog_id_#{blog_id}.store('blog_txt_all',@blog_id_#{blog_id}_txt_all[0..50] << '...')")
      #min_img_numにimg_を連結
      num=eval("@blog_id_#{blog_id}['min_img_num']").to_s
      eval("@blog_id_#{blog_id}.store('min_img_path', @blog_id_#{blog_id}['#{num}'])")
      logger.debug(eval("@blog_id_#{blog_id}"))
      #@blog_id_XXには以下が入っている。XXにはblog_idが入っている
      #{"max_content_num"個記事と写真の総数(数字) "min_img_num"=最初の画像の記事内ID(数字),
      #"id"=>記事ID(数字), "created_at"=>日付, "updated_at"=>日付, "title"=>"タイトル(文字列)",
      #記事内ID=>コンテンツ(画像へのパスか、記事のそのもの)※記事内ID分繰り返し,
      #"blog_txt_all"=>indexに表示させる記事 記事最初の100文字(文字列),
      #"min_img_path"=>"indexに表示させる画像のパス"}
    end
    #-------------------------------------------

  end

end
