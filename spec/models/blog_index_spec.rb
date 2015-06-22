require 'rails_helper'

RSpec.describe BlogIndex, :type => :model do

  context "validation test" do
    context "with title" do
      subject {FactoryGirl.build(:blog_index)}
      #フィールドのテスト ファクトリが使用できること
      it { is_expected.to be_valid }
    end
  end

  #メソッドのテスト
  context "method test" do
    before do
      @blog_title=FactoryGirl.create(:blog_index)
      @update_blog_title = FactoryGirl.build(:blog_index ,:as_update_data)
      @result_blog_title=BlogIndex.select_id()
    end

    #select_id
    context "select_id with valid parameter" do
    #BlogIndexのidを取得する。
      it "can select_id and get blog_index id" do
        @result_blog_title=BlogIndex.select_id()
        expect(@result_blog_title).to_not be_empty
      end
    end

    #select_title
    context "select_title with valid parameter" do
    #BlogIndexのidを取得する。
      it "can select_title and get blog_index id,title" do
        @result_blog_title=BlogIndex.select_title()
        expect(@result_blog_title).to_not be_empty
      end
    end

    #fild_by_detail(id)
    context "fild_by_detail(id) with valid parameter" do
    #BlogIndexのidを取得する。
      it "can fild_by_detail(id) and get blog_index id,title" do
        @result_blog_title=BlogIndex.fild_by_detail(@blog_title.id)
        expect(@result_blog_title).to_not be_empty
      end
    end
  end
end
