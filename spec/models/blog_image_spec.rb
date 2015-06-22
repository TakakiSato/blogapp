require 'rails_helper'

RSpec.describe BlogImage, :type => :model do
#フィールドのテスト ファクトリが使用できること
  context "validation test" do
    context "with image" do
      subject {FactoryGirl.build(:blog_image)}
      it { is_expected.to be_valid }
    end

    #imageがnullのものはエラーとなること
    context "without image" do
      subject {FactoryGirl.build(:blog_image, :as_image_null)}
      #tilteがなければ無効
      it { is_expected.to_not be_valid }
    end
  end

  context "method test" do
    before do
      @blog_image=FactoryGirl.create(:blog_image)
      @update_blog_image = FactoryGirl.build(:blog_image ,:as_update_data)
      @result_blog_image=BlogImage.find_by_blog_index_id(@blog_image.blog_index_id)
      FactoryGirl.create_list(:blog_image,10)
    end

    #メソッドのテスト
    #find_by_max_blog_index_id
    context "find_by_max_blog_index_id with valid parameter" do
    #同じblog_index_idを持つレコードのうち最大のimage_idを取得する。
      it "can take max image_id of the same blog_index_id" do
        @max_blog_image_id=BlogImage.find_by_max_blog_index_id(@blog_image.blog_index_id)
        expect(@max_blog_image_id).to eq 14
      end
    end
    #find_by_blog_index_id
    context "find_by_blog_index_id with valid parameter" do
    #引数で渡された index_idのblog_imageのidを取得する。
      it "can find by blog_index_id and get blog_image summary" do
        expect(@result_blog_image).to_not be_empty
      end

      #idを取得する。
      it "can take id" do
        expect(@result_blog_image[0].id).to eq @blog_image.id
      end
      #blog_index_idを取得する。
      it "can take blog_index_id" do
        expect(@result_blog_image[0].blog_index_id).to eq @blog_image.blog_index_id
      end
      #image_idを取得する。
      it "can take image_id" do
        expect(@result_blog_image[0].image_id).to eq @blog_image.image_id
      end
      #imageを取得する。
      it "can take image" do
        expect(@result_blog_image[0].image).to eq @blog_image.image
      end
    end

    #fild_by_detail
    context "fild_by_detail with valid parameter" do
      it "can find by blog_image.id" do
        @blog_image_detail=BlogImage.fild_by_detail(@blog_image.id)
        expect(@blog_image_detail[0].image).to eq @blog_image.image
      end
    end

    #update_image
    context "find_by_blog_index_id with valid parameter" do
      it "can find by blog_image.id and update blog_image" do
        p @update_blog_image.image
        @result_blog_image=BlogImage.update_image(@blog_image.id, @update_blog_image.image)
        expect(@result_blog_image).to eq 1
      end
    end
  end
end