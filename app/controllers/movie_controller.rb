class MovieController < ApplicationController
  def search
    @list = SearchMovie.new(params[:movie_title] ).perform
  end

  def index
  end
end
