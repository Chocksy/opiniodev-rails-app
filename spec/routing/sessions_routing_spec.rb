require "spec_helper"

describe SessionsController do
  describe "routing" do

    it "routes to #create" do
      get("/auth/twitter/callback").should route_to("sessions#create",:provider=>"twitter")
    end

    it "routes to #create post" do
      post("/auth/twitter/callback").should route_to("sessions#create",:provider=>"twitter")
    end

    it "routes to #destroy" do
      get("/signout").should route_to("sessions#destroy")
    end

  end
end
