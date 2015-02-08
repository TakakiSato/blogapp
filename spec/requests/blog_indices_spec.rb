require 'rails_helper'

RSpec.describe "BlogIndices", :type => :request do
  describe "GET /blog_indices" do
    it "works! (now write some real specs)" do
      get blog_indices_path
      expect(response.status).to be(200)
    end
  end
end
