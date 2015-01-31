require 'rails_helper'

RSpec.describe "blog_users/edit", :type => :view do
  before(:each) do
    @blog_user = assign(:blog_user, BlogUser.create!())
  end

  it "renders the edit blog_user form" do
    render

    assert_select "form[action=?][method=?]", blog_user_path(@blog_user), "post" do
    end
  end
end
