class SearchMovie
  require 'dotenv/load'
  def initialize(string)
    @name = string
  end

  def auth
    Tmdb::Api.key(ENV['API_KEY'])
  end

  def search
    @search = Tmdb::Search.new
    @search.resource("movie") # determines type of resource
    @search.query(@name) # the query to search against
    @hash_result = @search.fetch # makes request
    @array_cleaned = []
    @hash_result.each { |movie|
      hash_movie = {}
      hash_movie["id"] = movie["id"]
      hash_movie["title"] = movie["title"]
      hash_movie["director"] = Tmdb::Movie.credits(movie["id"])["crew"][0]["name"]
      hash_movie["date"] = movie["release_date"]
      hash_movie["poster"] = movie["poster_path"]
      @array_cleaned << hash_movie
    }
    @array_cleaned

  end

  def perform
    auth
    search
  end
end
