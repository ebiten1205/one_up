class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_customer.notifications.order(created_at: :desc)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
  
  def destroy
    @notifications = current_customer.notifications.destroy_all
    redirect_to notifications_path, notice: "通知を削除しました。"
  end
end
