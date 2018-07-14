require 'rails_helper'

RSpec.describe "person/show.html.erb", type: :view do
  before(:each) do
    @person_id = 16483 #Sylvester Stallone
    @person = Person.one(@person_id)
  end

  describe "GET #index view of a singular actor" do
    it "Returns the correct actor - Sylvester Stallone" do
      render
      expect(rendered).to match /Sylvester Stallone/
    end
    it "returns a biography" do
      expect(@person['biography']).not_to be_empty
    end
    it "Does not render a death date - he is still alive!" do
      expect(@person['deathday']).to be_falsey
    end
    it "Does return an image URL" do
      expect(@person['profile_path']).to be_truthy
    end

  end

end
