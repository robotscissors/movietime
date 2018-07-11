require 'rails_helper'

RSpec.describe Movie, type: :model do

  describe "Movie /discover/tv" do
    it "returns success" do
      api_call = Movie.popular_tv
      expect(api_call.respond_to?(:response)).to be_truthy
    end
  end

end
