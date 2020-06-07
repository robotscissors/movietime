class Tv
  include HTTParty

  base_uri 'https://api.themoviedb.org/3/account'
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

  def self.reviews(tv_id)
    get("/tv/#{tv_id}/reviews",query: {})
  end
end
