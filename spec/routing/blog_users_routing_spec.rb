require "rails_helper"

RSpec.describe BlogUsersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/blog_users").to route_to("blog_users#index")
    end

    it "routes to #new" do
      expect(:get => "/blog_users/new").to route_to("blog_users#new")
    end

    it "routes to #show" do
      expect(:get => "/blog_users/1").to route_to("blog_users#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/blog_users/1/edit").to route_to("blog_users#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/blog_users").to route_to("blog_users#create")
    end

    it "routes to #update" do
      expect(:put => "/blog_users/1").to route_to("blog_users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/blog_users/1").to route_to("blog_users#destroy", :id => "1")
    end

  end
end
