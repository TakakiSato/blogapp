require 'rails_helper'

RSpec.describe "blog_indices/new", :type => :view do
  before(:each) do
    assign(:blog_index, BlogIndex.new())
  end

  it "renders new blog_index form" do
    render

    assert_select "form[action=?][method=?]", blog_indices_path, "post" do
    end
  end
end
