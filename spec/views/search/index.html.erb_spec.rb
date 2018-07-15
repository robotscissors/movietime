require 'rails_helper'

RSpec.describe "search/index.html.erb", type: :view do

  before(:each) do
    @term = "brad"
    @page = 1
    @search_results = Search.for(@term,@page)['results']
    @total_pages = 5 #to test view
  end

  describe "GET results view of search for items named brad" do
    it "Returns the correct page for search" do
      render
      expect(rendered).to match /Search Results/
    end

    it "Returns the correct page for search" do
      render
      expect(rendered).to match /Brad Pitt/
    end
  end
end
