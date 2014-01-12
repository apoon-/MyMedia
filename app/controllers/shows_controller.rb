class ShowsController < ApplicationController
  def index
    @pop_shows = Tmdb::TV.popular
    @top_shows = Tmdb::TV.top_rated
  end

  def show
    @show = Tmdb::TV.detail(params[:id])
    next_episode(@show)
  end

  def next_episode(show)
    @num_of_seasons = show.seasons.last["season_number"]
    @series = Tmdb::Season.detail(params[:id], @num_of_seasons)["episodes"]
    @date = (Time.now - 86400).strftime('%Y-%m-%d')

    @future = @series.select {|s| 
      unless s['air_date'] == nil
        s["air_date"] > @date
      end
    }
  end

  def search
    @result = Tmdb::TV.find(params[:s])
  end

  private

  def show_params
    params.require(:show).permit(:name, :description, :id)
  end
end
