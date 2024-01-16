class Notification < ApplicationRecord
  belongs_to :notificatable, polymorphic: true
  belongs_to :customer
  
  enum action_type: { commented_to_own_post: 0, liked_to_own_post: 1, followed_me: 3}
end
