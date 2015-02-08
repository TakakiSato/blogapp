require 'rails_helper'

RSpec.describe "blog_users/index", :type => :view do
  before(:each) do
    assign(:blog_users, [
      BlogUser.create!(),
      BlogUser.create!()
    ])
  end

  it "renders a list of blog_users" do
    render
  end
end
