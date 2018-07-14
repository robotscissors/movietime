require 'rails_helper'

RSpec.describe TvController, type: :controller do

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
      get :show,  params: { tv_id: "63247" }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns and renders template" do
      get :show, params: { tv_id: "63247" }
      expect(response).to render_template("show")
    end
  end
end
