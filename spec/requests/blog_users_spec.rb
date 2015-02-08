require 'rails_helper'

RSpec.describe "BlogUsers", :type => :request do
  describe "GET /blog_users" do
    it "works! (now write some real specs)" do
      get blog_users_path
      expect(response.status).to be(200)
    end
  end
end
