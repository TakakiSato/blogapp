require 'rails_helper'

RSpec.describe BlogTextsController, :type => :controller do
  describe "POST #create" do
    before {
      @valid_params ={"1"=>"テキスト一つ目", "3"=>"テキスト二つ目", "5"=>"テクスト三つめ"}
      @invalid_params={"1"=>nil, "3"=>nil, "5"=>nil}
      @blog_index = FactoryGirl.create(:blog_index)
    }

    # 有効な属性の場合
    context "with valid attributes" do
    # データベースに新しいタスクを保存すること
      it "saves the new blog_texts_controller in the database" do
      #expect{
      #post :create, blog_texts: @valid_params, index_id:
      #}.to change(BlogText, :count).by(3)
        blog_texts_controller=BlogTextsController.new
        expect{
          blog_texts_controller.create(@valid_params,@blog_index.id)
        }.to change(BlogText, :count).by(3)
      end
    end

    #無効な属性の場合
    context "with invalid attributes" do
    # データベースに新しいタスクを保存すること
      it "returns an error " do
        blog_texts_controller=BlogTextsController.new
        expect{
          text_array_size=blog_texts_controller.create(@invalid_params,@blog_index.id)
        }.to raise_error ("message")
      end
    end
  end

  describe "GET #index" do
    before {
      @blog_texts=FactoryGirl.create_list(:blog_text, 25)
      @blog_texts_controller=BlogTextsController.new
      @blog_text_ids=[]
    }
    it "select text by index_ids" do
    #DBに登録されたblog_textの:text_id,:textを取得する。
      for blog_text in @blog_texts do
        @blog_text_ids.push(blog_text.index_id)
      end
      @blog_text_array=@blog_texts_controller.index(@blog_text_ids)
      expect(@blog_text_array.size).to eq 25
    end
  end

  describe "GET #show" do
    before {
      @blog_texts=FactoryGirl.create(:blog_text)
      @blog_texts_controller=BlogTextsController.new
    }
    it "select text by index_id" do
    #DBに登録されたblog_textの:text_id,:textを取得する。
      @blog_text_array=@blog_texts_controller.show(@blog_texts.index_id)
      expect(@blog_text_array.size).to eq 1
    end
  end

  describe "GET #update" do
    before {
      @blog_text = FactoryGirl.create(:blog_text )
      @update_blog_text = FactoryGirl.build(:blog_text ,:as_update_data)
      @blog_texts_controller=BlogTextsController.new
    }
    it "update blog_text text" do
    #DBに登録されたblog_textの:textを更新する。
    @blog_textr=@blog_texts_controller.update(@blog_text.id,@update_blog_text.text)
      expect(@update_blog_text.text).to eq "update text"
    end
  end
end
