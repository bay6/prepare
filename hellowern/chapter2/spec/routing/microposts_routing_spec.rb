require "spec_helper"

describe MicropostsController do
  describe "routing" do

    it "routes to #index" do
      get("/microposts").should route_to("microposts#index")
    end

    it "routes to #new" do
      get("/microposts/new").should route_to("microposts#new")
    end

    it "routes to #show" do
      get("/microposts/1").should route_to("microposts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/microposts/1/edit").should route_to("microposts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/microposts").should route_to("microposts#create")
    end

    it "routes to #update" do
      put("/microposts/1").should route_to("microposts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/microposts/1").should route_to("microposts#destroy", :id => "1")
    end

  end
end
