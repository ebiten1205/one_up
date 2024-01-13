class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_customer.notifications.order(created_at: :desc)
  end
  
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to notifications_path, notice: "通知を削除しました。"
  end
end
