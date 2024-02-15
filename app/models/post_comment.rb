class PostComment < ApplicationRecord
    belongs_to :customer
    belongs_to :post
    
    has_one :notification, as: :notificatable, dependent: :destroy
    
    after_create_commit :create_notifications
    
    validates :content, presence: true
    
    private
    
    def create_notifications
      Notification.create(notificatable: self, customer: self.post.customer, action_type: :commented_to_own_post)
      
    end
end
