require 'rails_helper'

RSpec.describe "person/index.html.erb", type: :view do

  before(:each) do
    @sort = "popularity.desc"
    @page = 1
    @people = Person.all(@page,@sort)['results'] #get top 6 for home page
  end

  describe "GET #index view of popular TV shows" do
    it "Returns the correct page Popular TV Shows" do
      render
      expect(rendered).to match /Your most popular people!/
    end

    it "returns a dataset" do
      expect(@people).not_to be_empty
    end
  end

end
