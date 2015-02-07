require 'rails_helper'

RSpec.describe "blog_users/show", :type => :view do
  before(:each) do
    @blog_user = assign(:blog_user, BlogUser.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
