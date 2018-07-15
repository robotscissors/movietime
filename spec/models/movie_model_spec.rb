require 'rails_helper'

RSpec.describe Movie, type: :model do

  describe "Movie /discover/movie" do
    it "returns success" do
      api_call = Movie.popular
      expect(api_call.respond_to?(:response)).to be_truthy
    end

    it "responds to calls to get popular movies" do
      @popular_movies = Movie.popular
      expect(@popular_movies).not_to be_empty
    end

    it "responds to calls to get all popular movies" do
      @sort = "popularity.desc"
      @page = 1
      @all_movies = Movie.all(@sort, @page)
      expect(@all_movies).not_to be_empty
      expect(@all_movies['page']).to eq(1) #make sure it returns the first page
    end

    it "responds to call to get only one movie and details" do
      @movie_id = 442249 #The first purge
      @movie = Movie.one(@movie_id)
      expect(@movie).not_to be_empty
      expect(@movie['title']).to include('The First Purge')
    end
  end
end
