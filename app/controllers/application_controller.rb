class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  require 'themoviedb'

  before_filter :set_config
  Tmdb::Api.key("85f8d457676de71d67d63a7b9bd245a9")

  Tmdb::Api.language("en")

  def set_config
    @config = Tmdb::Configuration.new
  end
end