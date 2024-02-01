class Admin::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  def create
  end
  
  def index
    @posts = Post.all
    @post = Post.new
    #@customer = current_customer
  end
  
  def show
    @post = Post.find(params[:id])
    @posts = Post.all
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to admin_post_path(@post.id)
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:name, :image, :content, :place)
  end
end
