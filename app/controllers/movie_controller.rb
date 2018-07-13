class MovieController < ApplicationController
  def index
    @page = params[:page].to_i
    @sort = params[:sort]
    @page = 1 if @page === 0
    @sort ||= "popularity.desc"
    @all_movies = Movie.all(@page,@sort)['results'] #returns 20
    #page management
    @next_page = @page + 1
    @back_page = @page - 1 if @page > 1
  end

  def show
    @movie_id = params[:movie_id].to_i
    if @movie_id
      @movie = Movie.one(@movie_id) #returns the details for one show\
    else
      #render the index template
    end
  end
end
