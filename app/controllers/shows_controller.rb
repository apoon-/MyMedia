class ShowsController < ApplicationController
  def index
    @popshows = Tmdb::TV.popular
    @topshows = Tmdb::TV.top_rated
  end

  def show
    @show = Tmdb::TV.detail(params[:id])
  end

  private

  def show_params
    params.require(:show).permit(:name, :description, :id)
  end
end
