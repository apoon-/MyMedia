class MoviesController < ApplicationController
  def index
    @now_movies = Tmdb::Movie.now_playing
    @up_movies = Tmdb::Movie.upcoming
    @pop_movies = Tmdb::Movie.popular
    @top_movies = Tmdb::Movie.top_rated
  end

  def show
    @movie = Tmdb::Movie.detail(params[:id])
    @cast = Tmdb::Movie.casts(params[:id])[0..9]
    @trailer = Tmdb::Movie.trailers(params[:id])
  end

  def search
    @result = Tmdb::Movie.find(params[:s])
  end

  private

  def show_params
    params.require(:show).permit(:name, :description, :id)
  end
end