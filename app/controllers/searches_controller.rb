class SearchesController < ApplicationController
  def new
  end

  def show
    @rants = Rant.search_all(params[:search])
  end
end