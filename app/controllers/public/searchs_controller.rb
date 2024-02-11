class Public::SearchsController < ApplicationController
  before_action :authenticate_customer!

	def search
		#@model = params[:model]
		#@content = params[:content]
		#@search = params[:search]
		#if @model == 'customer'
			#@records = Customer.search_for(@content, @search)
		#else
			#@records = Post.search_for(@content, @search)
		#end
		
		@range = params[:range]
    @word = params[:word]

    if @range == "Customer"
      @s = Customer.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
	end

  
  def genre_search
    @genre_id = params[:genre_id]
    @posts = Post.where(genre_id: @genre_id)
  end
end
