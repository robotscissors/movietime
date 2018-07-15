require 'rails_helper'

RSpec.describe Search, type: :model do

  describe "Search /search/multi" do
    it "returns success" do
      @term = "brad"
      @page = 1
      api_call = Search.for(@term, @page)
      expect(api_call.respond_to?(:response)).to be_truthy
    end

    it "responds to search for 'brad' " do
      @term = "brad"
      @page = 1
      @results = Search.for(@term, @page)
      expect(@results).not_to be_empty
    end

    it "responds to search even if we don't include page number" do
      @term = "brad"
      @results = Search.for(@term, @page)
      expect(@results).not_to be_empty
    end

    it "returns an error if no term is used" do
      @results = Search.for(@term, @page)
      expect(@results['errors']).to include('query must be provided')
    end
  end
end
