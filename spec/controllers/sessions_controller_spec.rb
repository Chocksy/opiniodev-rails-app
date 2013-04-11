require 'spec_helper'

describe SessionsController do
  describe "Auth Twitter" do
    before do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    end

    it "creates a user session" do
      post :create,{:provider=>"twitter"}
      response.should be_redirect
      session[:user_id].should_not be_nil
    end

    it "signs out user" do
      delete :destroy
      response.should be_redirect
      session[:user_id].should be_nil
    end

  end

  describe "Auth Facebook" do
    before do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end

    it "creates a user session" do
      post :create,{:provider=>"facebook"}
      response.should be_redirect
      session[:user_id].should_not be_nil
    end

    it "signs out user" do
      delete :destroy
      response.should be_redirect
      session[:user_id].should be_nil
    end
  end

end
