class Relationship < ApplicationRecord
  #class_nameとは
#関連名と参照先のクラス名を異なるものに置き換えることができるオプション。
#モデル名を直接指定できる。
#関連付けの相手となるオブジェクト名を関連付け名から生成できない事情がある場合に役立つ！
  belongs_to :follow, class_name: "customer"
  belongs_to :follower, class_name: "customer"
  
  #　フォローしたときの処理
  def follow(customer_id)
    follows.create(follow_id: customer_id)
  end
  
  #　フォローを外すときの処理
  def unfollow(customer_id)
    followers.find_by(follower_id: customer_id).destroy
  end
  
  #フォローしていればtrueを返す
  def following?(customer)
    following_customers.include?(customer)
  end
end
