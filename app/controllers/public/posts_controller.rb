class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @post = current_customer.posts.build(post_params)
    @post.genre_id = params[:post][:genre_id]
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "入力内容に不備があります。未入力での投稿はできません。"
      redirect_to new_post_path
    end
  end
    
  def index
    @posts = Post.all
    @post = Post.new
    @customer = current_customer
  end
    
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    flash[:notice] = "You have updated book successfully."
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content, :place, :image, :genre_id)
  end
    
end
