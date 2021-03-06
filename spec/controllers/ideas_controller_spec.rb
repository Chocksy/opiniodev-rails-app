require 'spec_helper'

describe IdeasController do

  let(:user) { create(:user) }

  def valid_attributes
    { "title" => "My new idea", "description"=>"My new idea description.", "user_id"=>user._id }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all ideas as @ideas" do
      idea = create(:idea)
      get :index
      assigns(:ideas).should eq([idea])
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Idea" do
        expect {
          post :create, {:idea => valid_attributes}, valid_session
        }.to change(Idea, :count).by(1)
      end

      it "assigns a newly created idea as @idea" do
        post :create, {:idea => valid_attributes}, valid_session
        assigns(:idea).should be_a(Idea)
        assigns(:idea).should be_persisted
      end

    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved idea as @idea" do
        # Trigger the behavior that occurs when invalid params are submitted
        Idea.any_instance.stub(:save).and_return(false)
        post :create, {:idea => { "title" => "invalid value" }}, valid_session
        assigns(:idea).should be_a_new(Idea)
      end
    end
  end

  describe "GET show" do
    let(:idea) { create(:idea) }

    it "responds successfully with an HTTP 200 status code" do
      get :show, {id:idea.id}
      expect(response).to be_success
      expect(response.code).to eq("200")
    end

    it "should get idea" do
      get :show, {id:idea.id}
      expect(assigns(:idea)).to eq(idea)
    end

    it "renders the :show view" do
      get :show, {id:idea.id}
      response.should render_template :show
    end
  end

end
