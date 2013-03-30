require 'spec_helper'

describe HomeController do

  describe "GET index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.code).to eq("200")
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
end
