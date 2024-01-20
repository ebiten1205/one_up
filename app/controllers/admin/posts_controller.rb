class Admin::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  def create
  end
  
  def index
    @post = Post.page(params[:page])
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to admin_post_path(@post.id)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:name, :image, :content, :place)
  end
end
