class Search
  include HTTParty

  base_uri 'https://api.themoviedb.org/3'
  default_params api_key: ENV['API_KEY']
  format :json

  def self.for(term, page)
    get("/search/multi", query: {query: term, page: page})
  end


end
