class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @post.genre_id =
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "入力内容に不備があります。未入力での投稿はできません。"
      redirect_to new_post_path
    end
  end
    
  def index
  end
    
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content, :place, :genre_id)
  end
    
end
