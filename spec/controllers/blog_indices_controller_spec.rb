require 'rails_helper'

RSpec.describe BlogIndicesController, :type => :controller do
# userをFactoryGirlで作る
  let(:user) { FactoryGirl.build(:user) }
  # 作ったユーザでログインする
  before do
    login_user user
    #blog_imageを生成
    @blog_image=FactoryGirl.create_list(:blog_image, 3)
    @blog_index=FactoryGirl.create(:blog_index)
  end

  describe "POST create" do
  # 有効な属性の場合
    context "with valid attributes" do
      it "saves the new blog_images in the database" do
        post :create,
          :blog_title => "テストタイトル",
          :blog_texts => "テスト本文",
          :blog_index_id => @blog_index.id
        expect(assigns(:blog_index_result)).to eq(1)
      end
    end
  end

  describe "GET index" do
  #BlogIndexが作成されること
    it {
      get :index
      expect(response).to render_template :index
    }
  end

  describe "GET show" do
    before {
      get :show, id: 1
    }
    it {
      expect(assigns(:result_blog_index_id)).to_not be_nil
    }
    #BlogTextが作成されること
    it {
      expect(assigns(:result_blog_texts)).to_not be_nil
    }
    #BlogImageが作成されること
    it {
      expect(assigns(:result_blog_images)).to_not be_nil
    }
    it {
      expect(response).to render_template :show
    }
  end

  describe "GET new" do
    before{
      get :new
    }
    it {
      expect(response).to render_template :new
    }

    it{
      expect(assigns(:blog_index)).to_not be_nil
    }
  end

  describe "GET edit" do
    before {get :edit, id:1}
    it{expect(response).to render_template :edit}
    it {
      expect(assigns(:result_blog_index_id)).to_not be_nil
    }
    #BlogTextが作成されること
    it {
      expect(assigns(:result_blog_texts)).to_not be_nil
    }
    #BlogImageが作成されること
    it {
      expect(assigns(:result_blog_images)).to_not be_nil
    }
  end

  describe "PUT update" do
    before {
      put :update,:id=>@blog_index.id ,:blog_title => "update title",:blog_texts => "update text"
    }

    #BlogIndexが作成されること
    it {
      expect(assigns(:title_update_num)).to eq 1
    }
    #BlogTextが作成されること
    it {
      expect(assigns(:text_update_num)).to eq 1
    }
    #BlogImageが作成されること
    it {
      expect(assigns(:image_update_nam)).to eq 1
    }
    # => indexにリダイレクトされること
    it {
      expect(response).to render_template :index
    }
  end

  describe "DELETE destroy" do
    before {
      delete :destroy, id:@blog_index.id
    }
    it {
      expect(response).to render_template :index
    }

    context "GET show after DELETE destroy" do
      before {
        get :show, id:@blog_index.id
      }
      #BlogIndexが削除されていること
      it {
        expect(assigns(:result_blog_index_id)).to be_empty
      }
      #BlogTextが削除されていること
      it {
        expect(assigns(:result_blog_texts)).to be_empty
      }
      #BlogImageが削除されていること
      it {
        expect(assigns(:result_blog_images)).to be_empty
      }
    end
  end
end
