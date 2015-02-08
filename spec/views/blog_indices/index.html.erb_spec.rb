require 'rails_helper'

RSpec.describe "blog_indices/index", :type => :view do
  before(:each) do
    assign(:blog_indices, [
      BlogIndex.create!(),
      BlogIndex.create!()
    ])
  end

  it "renders a list of blog_indices" do
    render
  end
end
