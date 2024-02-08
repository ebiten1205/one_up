class Public::TimelinesController < ApplicationController
  def index
    #@timelines = Timeline.all
    #@timelines = Timeline.includes(:timelineable).where(customer_id: [current_customer.id] + current_customer.following_customers)
    #if params[:timeline_type] == "post"
      #timelines = Timeline.includes(:timelineable).where(timelineable_type: "Post")
    #elsif params[:timeline_type] == "rt"
      #@timelines = Timeline.includes(:timelineable).where(timelineable_type: "Rt")
    #else
    @timelines = Timeline.includes(:timelineable).all
    if params[:timelineable_type] == "post"
      @timelines = Post.where(customer_id:current_customer.follows.pluck(:follower_id))
      @timelines = Post.where(customer_id:current_customer.posts.pluck(:post_id))
    elsif params[:timelineable_type] == "rt"
      @timelines = Timeline.includes(:timelineable).where(timelineable_type: "rt")
    else
    end
  end
end
