require 'rails_helper'

RSpec.describe Tv, type: :model do

  describe "TV/discover/tv" do
    it "returns success" do
      api_call = Tv.popular_tv
      expect(api_call.respond_to?(:response)).to be_truthy
    end

    it "responds to calls to get popular TV programs" do
      @popular_tv = Tv.popular_tv
      expect(@popular_tv).not_to be_empty
    end

    it "responds to calls to get all popular TV programs" do
      @sort = "popularity.desc"
      @page = 1
      @all_tv = Tv.all(@sort, @page)
      expect(@all_tv).not_to be_empty
      expect(@all_tv['page']).to eq(1) #make sure it returns the first page
    end

    it "responds to call to get only one tv program and details" do
      @tv_id = 1396 #The first purge
      @tv = Tv.one(@tv_id)
      expect(@tv).not_to be_empty
      expect(@tv['original_name']).to include('Breaking Bad')
    end

    it "responds to reviews if they are available" do
      @tv_id = 1396 #The first purge
      @tv = Tv.reviews(@tv_id)
      expect(@tv).not_to be_empty #there are reviews for breaking bad
    end

  end
end
