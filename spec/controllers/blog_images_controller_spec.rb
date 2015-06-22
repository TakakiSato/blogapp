require 'rails_helper'

RSpec.describe BlogImagesController, :type => :controller do
# userをFactoryGirlで作る
  let(:user) { FactoryGirl.build(:user) }

  describe "POST #create" do
    before {
      login_user user
    }

    # 有効な属性の場合
    context "with valid attributes" do
      before{
      #blog_imdexを生成
        @blog_image=FactoryGirl.build(:blog_image)
        #ファイルが登録されるディレクトリを指定
        @dir_path = "./public/images/#{Time.now.strftime("%Y")}/#{@blog_image.blog_index_id}/"
        #登録する画像準備
        IMG_FILE_NAME = 'test1.jpg'
        @img_file_path = 'file/'+IMG_FILE_NAME
        #登録する画像準備
        upload_file_path = @dir_path + IMG_FILE_NAME
        #ファイル事前に削除
        File.unlink(upload_file_path) if File.exist?(upload_file_path)
      }

      subject {
        post :create,
            :blog_images => fixture_file_upload(@img_file_path, 'image/jpg')
      }
      # データベースに新しいimageを保存すること
      it { is_expected.to change(BlogImage, :count).by(1) }

      it "saves the new blog_images in the database" do
        expect{
          post :create,
          :blog_images => fixture_file_upload(@img_file_path, 'image/jpg')
        }.to change(BlogImage, :count).by(1)
      end
    end
  end

  describe "GET #index" do
    before {
      @blog_images=FactoryGirl.create_list(:blog_image, 3)
    }
    it "select image by index_ids" do
    #DBに登録されたblog_imageの:image_id,:imageを取得する。
      blog_images_controller=BlogImagesController.new
      @result_blog_images=blog_images_controller.index(@blog_images[0].blog_index_id)
      expect(@result_blog_images.size).to eq 3
    end
  end

  describe "GET #show" do
    before {
      @blog_images=FactoryGirl.create_list(:blog_image, 3)
    }
    it "select image by index_ids" do
    #DBに登録されたblog_imageの:image_id,:imageを取得する。
      blog_images_controller=BlogImagesController.new
      @result_blog_images=blog_images_controller.index(@blog_images[0].blog_index_id)
      expect(@result_blog_images.size).to eq 3
    end
  end

  describe "GET #update" do
    before {
      @blog_image = FactoryGirl.create(:blog_image )
      @update_blog_image = FactoryGirl.build(:blog_image ,:as_update_data)
      @blog_images_controller=BlogImagesController.new
    }
    it "update blog_image" do
    #DBに登録されたblog_imageの:imageを更新する。
      @blog_image=@blog_images_controller.update(@blog_image.id,@update_blog_image.image)
      expect(@update_blog_image.image).to eq "/update/update/update.jpg"
    end
  end
end
