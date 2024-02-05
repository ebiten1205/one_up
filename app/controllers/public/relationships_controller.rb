class Public::RelationshipsController < ApplicationController
  # フォローするとき
  def create
    customer_id = params[:customer_id]
    current_customer.follow(customer_id)
    redirect_to request.referer
  end
  
  # フォロー外すとき
  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer  
  end
end
