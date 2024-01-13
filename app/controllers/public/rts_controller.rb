class Public::RtsController < ApplicationController
  def create
    @rt = Rt.new(customer_id: current_customer.id, post_id: params[:post_id])
    if @rt.save
      redirect_to timeline_path, notice: "RT was successfully created."
    else
      redirect_to timeline_path, alert: "Failed to create RT."
    end
  end
  
  def destroy
    @rt = Rt.find(params[:id])
    @rt.destroy
    redirect_to timeline_path, notice: "RT was successfully destroyed."
  end
end
