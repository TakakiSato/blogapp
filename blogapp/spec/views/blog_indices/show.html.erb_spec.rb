require 'rails_helper'

RSpec.describe "blog_indices/show", :type => :view do
  before(:each) do
    @blog_index = assign(:blog_index, BlogIndex.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
