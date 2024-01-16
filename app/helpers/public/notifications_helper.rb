module Public::NotificationsHelper
  def transition_path(notification)
    case notification.action_type.to_sym
    when :commented_to_own_post
      post_path(notification.notificatable.post, anchor: "comment-#{notification.notificatable.id}")
    when :liked_to_own_post
      post_path(notification.notificatable.post)
    when :followed_me
      customer_path(notification.notificatable.follower)
    end
  end
end
