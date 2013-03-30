require 'spec_helper'

describe IdeasController do

  describe "GET index" do
    it "assigns all ideas as @ideas" do
      idea = create(:idea)
      get :index
      assigns(:ideas).should eq([idea])
    end
  end

end
