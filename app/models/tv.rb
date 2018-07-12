class Tv
  include HTTParty

  base_uri 'https://api.themoviedb.org/3'
  default_params api_key: ENV['API_KEY']
  format :json

  def self.popular_tv
    get("/discover/tv", query: {sort_by: "popularity.desc"})
  end

  def self.all(page, sort)
    get("/discover/tv", query: {sort_by: sort, page: page})
  end

  def self.one(tv_id)
    get("/tv/#{tv_id}",query: {})
  end
end
