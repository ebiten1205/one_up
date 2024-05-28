class Public::RtsController < ApplicationController
  before_action :set_post
  
  
  
  def create 
    @rt = Rt.new(customer_id: current_customer.id, post_id: params[:post_id])
    if @rt.save!
      
      timeline = Timeline.new
      timeline.timelineable = @rt
      timeline.customer_id = current_customer.id
      params[:timelineable_type] = "rt"
      timeline.save!
      @timelines = Timeline.all
      redirect_to timeline_path, notice: "RT was successfully created."
    else
      @timelines = Timeline.all
      redirect_to timeline_path, alert: "Failed to create RT."
    end
  end
  
  def destroy 
    @rt = Rt.find(params[:id])
    @rt.destroy!
    @timelines = Timeline.all
    redirect_to timeline_path, notice: "RT was successfully destroyed."
  end
  
  private
  def set_post  
    @post = Post.find(params[:post_id])
    if @post.nil?
      redirect_to root_path, alert: '該当の投稿が見つかりません'
    end
  end
end
