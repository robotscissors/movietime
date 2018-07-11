class WelcomeController < ApplicationController
  def index
    @popular_tv = Tv.popular_tv['results'].take(6) #get top 6 for home page
  end
end
