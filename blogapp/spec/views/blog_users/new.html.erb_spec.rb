require 'rails_helper'

RSpec.describe "blog_users/new", :type => :view do
  before(:each) do
    assign(:blog_user, BlogUser.new())
  end

  it "renders new blog_user form" do
    render

    assert_select "form[action=?][method=?]", blog_users_path, "post" do
    end
  end
end
