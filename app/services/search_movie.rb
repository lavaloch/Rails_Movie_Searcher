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
      credit = Tmdb::Movie.credits(movie["id"])
      if !credit.empty?
        if !credit["crew"].empty?
          if credit["crew"][0]["name"]
            director = credit["crew"][0]["name"]
          end
        end
      else director = nil
      end
      hash_movie["director"] = director
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
