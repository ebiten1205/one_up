class Public::SearchsController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		@search = params[:search]
		if @model == 'customer'
			@records = Customer.search_for(@content, @search)
		else
			@records = Post.search_for(@content, @search)
		end
	end

  
  def genre_search
    @genre_id = params[:genre_id]
    @posts = Post.where(genre_id: @genre_id)
  end
end
