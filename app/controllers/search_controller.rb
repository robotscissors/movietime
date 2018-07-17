class SearchController < ApplicationController
  def index
    #session if variable is empty then it is equal to the search_query and page number
    @search_query = params[:query]
    @page = params[:page].to_i
    session[:current_search_term] ||= params[:query]
    if !@search_query
      @search_query = session[:current_search_term]
      @page = session[:current_search_page]
    else
      session[:current_search_term] = @search_query
      session[:current_search_page] = @page
    end
    @page = 1 if @page === 0
    @search = Search.for(@search_query,@page)
    @total_pages = @search['total_pages']
    @total_results = @search['total_results']
    @search_results = @search['results']
    @errors = @search['errors']
  end
end
