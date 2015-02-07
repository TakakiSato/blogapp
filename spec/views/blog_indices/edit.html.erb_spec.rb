require 'rails_helper'

RSpec.describe "blog_indices/edit", :type => :view do
  before(:each) do
    @blog_index = assign(:blog_index, BlogIndex.create!())
  end

  it "renders the edit blog_index form" do
    render

    assert_select "form[action=?][method=?]", blog_index_path(@blog_index), "post" do
    end
  end
end
