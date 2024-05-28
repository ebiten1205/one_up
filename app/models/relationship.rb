class Relationship < ApplicationRecord
  belongs_to :follow, class_name: "Customer"
  belongs_to :follower, class_name: "Customer"
  
  has_one :notification, as: :notificatable, dependent: :destroy
  
  after_create_commit :create_notifications
  
  private
  
  def create_notifications
    Notification.create(notificatable: self, customer: follower, action_type: :followed_me)
  end
end
