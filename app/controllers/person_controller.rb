class PersonController < ApplicationController
  def index
    @page = params[:page].to_i
    @sort = params[:sort]
    @page = 1 if @page === 0
    @sort ||= "popularity.desc"
    @people = Person.all(@page,@sort)['results'] #returns 20
    #page management
    @next_page = @page + 1
    @back_page = @page - 1 if @page > 1
  end

  def show
    @person_id = params[:person_id].to_i
    if @person_id
      @person = Person.one(@person_id) #returns the details for one show\
    else
      @errors = "Hmm, I don't know what happened here. Try again."
    end
  end
end
