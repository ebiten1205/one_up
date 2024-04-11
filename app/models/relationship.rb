class Relationship < ApplicationRecord
  #class_nameとは
#関連名と参照先のクラス名を異なるものに置き換えることができるオプション。
#モデル名を直接指定できる。
#関連付けの相手となるオブジェクト名を関連付け名から生成できない事情がある場合に役立つ！
  belongs_to :follow, class_name: "Customer"
  belongs_to :follower, class_name: "Customer"
  
  has_one :notification, as: :notificatable, dependent: :destroy
  
  after_create_commit :create_notifications
  
  private
  
  def create_notifications
    Notification.create(notificatable: self, customer: follower, action_type: :followed_me)
  end
end
