require "rails_helper"

RSpec.describe BlogIndicesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/blog_indices").to route_to("blog_indices#index")
    end

    it "routes to #new" do
      expect(:get => "/blog_indices/new").to route_to("blog_indices#new")
    end

    it "routes to #show" do
      expect(:get => "/blog_indices/1").to route_to("blog_indices#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/blog_indices/1/edit").to route_to("blog_indices#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/blog_indices").to route_to("blog_indices#create")
    end

    it "routes to #update" do
      expect(:put => "/blog_indices/1").to route_to("blog_indices#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/blog_indices/1").to route_to("blog_indices#destroy", :id => "1")
    end

  end
end
