class SearchController < ApplicationController
  def index
    @search_query = params[:query]
    @page = params[:page]
    @page ||= 1
    @search = Search.for(@search_query,@page)
    @total_pages = @search['total_pages']
    @total_results = @search['total_results']
    @search_results = @search['results']
  end
end
