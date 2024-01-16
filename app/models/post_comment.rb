class PostComment < ApplicationRecord
    belongs_to :customer
    belongs_to :post
    
    has_one :notification, as: :notificatable, dependent: :destroy
    
    after_create_commit :create_notifications
    
    validates :comment, presence: true
    
    private
    
    def create_notifications
      Notification.create(notificatable: self, customer: post_comment.customer, action_type: :commented_to_own_post)
    end
end
