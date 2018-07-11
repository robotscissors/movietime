class Tv
  include HTTParty

  base_uri 'https://api.themoviedb.org/3'
  default_params api_key: ENV['API_KEY']
  format :json

  def self.popular_tv
    get("/discover/tv", query: {sort_by: "popularity.desc"})
  end


end
