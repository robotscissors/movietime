require 'rails_helper'

RSpec.describe "tv/show.html.erb", type: :view do
  before(:each) do
    @tv_id = 121 #Doctor who with review
    @tv_program = Tv.one(@tv_id) #get top 6 for home page
    @reviews = Tv.reviews(@tv_id)['results'].take(3)
  end

  describe "GET #index view of a singular popular TV shows" do
    it "Returns the correct page TV Show (121)" do
      render
      expect(rendered).to match /More about the TV program/
      expect(rendered).to match /Doctor Who/
    end
    it "returns a dataset" do
      expect(@tv_program).not_to be_empty
    end
    it "returns a set of reviews (for this tv show)" do
      expect(@reviews).not_to be_empty
    end
    it "Does return an image URL" do
      expect(@tv_program['poster_path']).to be_truthy
    end
  end

end
