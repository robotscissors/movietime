require 'rails_helper'

RSpec.describe "movie/show.html.erb", type: :view do
  before(:each) do
    @movie_id = 338970 #Tomb Raider
    @movie = Movie.one(@movie_id)
  end

  describe "GET #show view of a singular movie" do
    it "Returns the correct movie - Tomb Raider" do
      render
      expect(rendered).to match /Tomb Raider/
    end
    it "returns an overview" do
      expect(@movie['overview']).not_to be_empty
    end
    it "Does return an image URL" do
      expect(@movie['poster_path']).to be_truthy
    end
  end

end
