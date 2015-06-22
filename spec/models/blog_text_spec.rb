require 'rails_helper'

RSpec.describe BlogText, :type => :model do

  context "validation test" do
    context "with text" do
      subject {FactoryGirl.build(:blog_text)}
      #フィールドのテスト ファクトリが使用できること
      it { is_expected.to be_valid }
    end

    #textがnullのものはエラーとなること
    context "without text" do
      subject {FactoryGirl.build(:blog_text, :as_text_null)}
      #tilteがなければ無効
      it { is_expected.to_not be_valid }
    end
  end

  #メソッドのテスト
  context "method test" do
    before do
      @blog_text=FactoryGirl.create(:blog_text)
      @update_blog_text = FactoryGirl.build(:blog_text ,:as_update_data)
      @result_blog_text=BlogText.find_by_blog_index_id(@blog_text.blog_index_id)
    end
    #find_by_blog_index_id
    context "find_by_blog_index_id with valid parameter" do
    #blog_index_idをもとにid,blog_index_id,text_id,textを選択する。
      it "can find by text_id and get blog_text summary" do
        expect(@result_blog_text).to_not be_empty
      end

      #idを取得する。
      it "can take id" do
        expect(@result_blog_text[0].id).to eq @blog_text.id
      end

      #blog_index_idを取得する。
      it "can take blog_index_id" do
        expect(@result_blog_text[0].blog_index_id).to eq @blog_text.blog_index_id
      end

      #text_idを取得する。
      it "can take text_id" do
        expect(@result_blog_text[0].text_id).to eq @blog_text.text_id
      end

      #textを取得する。
      it "can take text" do
        expect(@result_blog_text[0].text).to eq @blog_text.text
      end

      #fild_by_detail(id)
      it "can find by blog_text.id and selected blog_text detail" do
        @blog_text_detail=BlogText.fild_by_detail(@blog_text.id)
        expect(@blog_text_detail).to_not be_empty
      end

      #update_text(id, text)
      it "can find by blog_text.id and update blog_text" do
        @result_blog_text=BlogText.update_text(@blog_text.id, @update_blog_text.text)
        expect(@result_blog_text).to eq 1
      end

    end
  end
end