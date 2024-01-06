class Post < ApplicationRecord
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :genres, dependent: :destroy
  belongs_to :customer
  
  def liked_by?(customer)
    likes.exists?(customer_id: customer_id)
  end
  
  # いいねをつけた投稿の取得
  def self.liked_posts(customer, page, per_page) # 1. モデル内での操作を開始
  includes(:likes) # 2. likes テーブルを結合
    .where(likes: { customer_id: customer.id }) # 3. ユーザーがいいねしたレコードを絞り込み
    .order(created_at: :desc) # 4. 投稿を作成日時の降順でソート
    .page(12) # 5. ページネーションのため、指定ページに表示するデータを選択
    .per(12) # 6. ページごとのデータ数を指定
  end
  
  def self.search_for(content, search)
    if search == 'perfect'
      Post.where(content: content)
    elsif search == 'forward'
      Post.where('content LIKE ?', content+'%')
    elsif search == 'backward'
      Post.where('content LIKE ?', '%'+content)
    else
      Post.where('content LIKE ?', '%'+content+'%')
    end
  end
  
end
