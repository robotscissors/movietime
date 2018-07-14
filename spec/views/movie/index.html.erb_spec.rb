require 'rails_helper'

RSpec.describe "movie/index.html.erb", type: :view do
  before(:each) do
    @page = 1
    @sore = "popularity.desc"
    @all_movies = Movie.all(@page,@sort)['results']
  end

  describe "GET #index view of popular movies" do
    it "Returns the correct page of movies" do
      render
      expect(rendered).to match /The Most Popular Movies/
    end
    it "returns a dataset" do
      expect(@all_movies).not_to be_empty
    end
  end
end
