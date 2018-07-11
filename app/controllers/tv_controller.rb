class TvController < ApplicationController
  def index
    @page = params[:page].to_i
    @sort = params[:sort]
    @page ||= 1
    @sort ||= "popularity.desc"
    @all_tv_programs = Tv.all(@page,@sort)['results'] #returns 20
    #page management
    @next_page = @page + 1
    @back_page = @page - 1 if @page > 1
  end

  def show

  end


end
