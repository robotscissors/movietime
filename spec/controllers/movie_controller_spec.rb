require 'rails_helper'

RSpec.describe MovieController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end
  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to render_template("show")
    end
  end
end
