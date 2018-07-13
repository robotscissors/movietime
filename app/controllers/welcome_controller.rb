class WelcomeController < ApplicationController
  def index
    @popular_tv = Tv.popular_tv['results'].take(12) #get top 6 for home page
    @popular_movie = Movie.popular['results'].take(6)
    @popular_people = Person.popular['results'].take(6)
  end
end
