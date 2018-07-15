require 'rails_helper'

RSpec.describe "tv/index.html.erb", type: :view do

  before(:each) do
    sort = "popularity.desc"
    page = 1
    @all_tv_programs = Tv.all(sort, page)['results'] #get top 6 for home page
  end

  describe "GET #index view of popular TV shows" do
    it "Returns the correct page Popular TV Shows" do
      render
      expect(rendered).to match /TV\'s Most Popular Shows/
    end

    it "returns a dataset" do
      expect(Tv.all("popularity.desc", 1)).not_to be_empty
    end
  end
end
