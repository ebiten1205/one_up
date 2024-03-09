class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @post = current_customer.posts.build(post_params)
    @post.genre_id = params[:post][:genre_id]
    if @post.save!
      #↓まずtimeline.post_idとtimeline.rt_idをsaveらいらいする
      #次にタイムラインモデルを作り、タイムラインアブルに"post"を入れ、saveで保存する
      #うまくタイムラインアブルに値を入れることができたらtimelinesのindex.html.erbに
      #投稿などが表示されるはず
      #@post = timeline.post_id
      #timeline.post_id.save
      timeline = Timeline.new
      timeline.timelineable = @post
      #timeline.post_id = @post.id
      timeline.customer_id = current_customer.id
      #timeline.timelineable_type = "post"
      params[:timelineable_type] = "post"
      timeline.save!
      
      #ポリモーフィック関連付けで"timelineable"に自分がフォローしている人の"id"もpostのcreate時に一緒に入れるため、ここに記述
      #follower_customersにしている理由は:follower_customers# 被フォロー関係を通じて参照→自分をフォローしている人にすることで
      #自分がフォローしている人＝相手から見ると自分をフォローしている人（follower_customers)となるため
      #表示するものはcurrent_customer.follower_customers（自分をフォローしている人の投稿（相互関係的に）になる）
      current_customer.follower_customers.each do | customer | 
        timeline = Timeline.new
        timeline.timelineable = @post
        timeline.customer_id = customer.id
        timeline.save!
      end
        
      # timeline をsaveする
      # timeline = Timeline.new
      # timeline.timelineable_type = "post"
      # timeline.save
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
    params.require(:post).permit(:content, :place, :image, :genre_id, :timelineable_type, :timeline)
  end
    
end
