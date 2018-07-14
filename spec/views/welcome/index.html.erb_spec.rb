require 'rails_helper'

RSpec.describe "welcome/index.html.erb", type: :view do
  before(:each) do
    @popular_tv = Tv.popular_tv['results'].take(1) #get top 6 for home page
    @popular_movie = Movie.popular['results'].take(1)
    @popular_people = Person.popular['results'].take(1)
  end

  describe "GET #index" do
    it "returns Popular TV Shows" do
      render
      expect(rendered).to match /Popular TV Shows/
    end

    it "returns Popular Movies" do
      render
      expect(rendered).to match /Popular Movies/
    end

    it "returns The Hottest Actors" do
      render
      expect(rendered).to match /The Hottest Actors/
    end
  end

end
