class Movie
  include HTTParty

  base_uri 'https://api.themoviedb.org/3'
  default_params api_key: ENV['API_KEY']
  format :json

  def self.popular
    get("/movie/popular", query: {sort_by: "popularity.desc"})
  end

  def self.all(page, sort)
    get("/movie/popular", query: {sort_by: sort, page: page})
  end

  def self.one(movie_id)
    get("/movie/#{movie_id}",query: {})
  end
end
