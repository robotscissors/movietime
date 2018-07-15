require 'rails_helper'

RSpec.describe Person, type: :model do

  describe "Person /discover/person" do
    it "returns success" do
      api_call = Person.popular
      expect(api_call.respond_to?(:response)).to be_truthy
    end

    it "responds to calls to get popular people" do
      @popular_people = Person.popular
      expect(@popular_people).not_to be_empty
    end

    it "responds to calls to get all popular people" do
      @sort = "popularity.desc"
      @page = 1
      @all_people = Person.all(@sort, @page)
      expect(@all_people).not_to be_empty
      expect(@all_people['page']).to eq(1) #make sure it returns the first page
    end

    it "responds to call to get only one person and details" do
      @person_id = 109513 #The first purge
      @person = Person.one(@person_id)
      expect(@person).not_to be_empty
      expect(@person['name']).to include('Alexandra Daddario')
    end
  end
end
