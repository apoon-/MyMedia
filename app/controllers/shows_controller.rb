class ShowsController < ApplicationController
  def index
    @popshows = Tmdb::TV.popular
    @topshows = Tmdb::TV.top_rated
  end

  def show
    @show = Tmdb::TV.detail(params[:id])
    next_episode(@show)
  end

  def next_episode(show)
    @num_of_seasons = show.seasons.last["season_number"]
    @series = Tmdb::Season.detail(params[:id], @num_of_seasons)["episodes"]
    @date = (Time.now - 86400).strftime('%Y-%m-%d')

    @future = @series.select {|s| s["air_date"] > @date}
  end

  private

  def show_params
    params.require(:show).permit(:name, :description, :id)
  end
end
