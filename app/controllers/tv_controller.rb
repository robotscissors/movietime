class TvController < ApplicationController
  def index
    @page = params[:page].to_i
    @sort = params[:sort]
    @page = 1 if @page === 0
    @sort ||= "popularity.desc"
    @all_tv_programs = Tv.all(@page,@sort)['results'] #returns 20
    #page management
    @next_page = @page + 1
    @back_page = @page - 1 if @page > 1
  end

  def show
    @tv_id = params[:tv_id].to_i
    if @tv_id
      @tv_program = Tv.one(@tv_id) #returns the details for one show\
    else
      #render the index template
    end
  end


end
