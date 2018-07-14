class SearchController < ApplicationController
  def index
    @search_query = params[:query]
    @page = params[:page].to_i
    @page = 1 if @page === 0
    @search = Search.for(@search_query,@page)
    @total_pages = @search['total_pages']
    @total_results = @search['total_results']
    @search_results = @search['results']
    @errors = @search['errors']
  end
end
