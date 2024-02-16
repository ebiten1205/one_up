class Public::GenresController < ApplicationController
  def genre_search
    @genres = Genre.all
  end
end
