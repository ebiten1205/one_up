class Post < ApplicationRecord
  has_one_attached :image
  has_one :notification, as: :notificatable, dependent: :destroy
  has_many :rts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_one :timeline, as: :timelineable, dependent: :destroy
  belongs_to :genre
  belongs_to :customer
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  def liked_by?(customer)
    likes.exists?(customer_id: customer.id)
  end
  
  # いいねをつけた投稿の取得
  def self.liked_posts(customer, page, per_page) # 1. モデル内での操作を開始
  includes(:likes) # 2. likes テーブルを結合
    .where(likes: { customer_id: customer.id }) # 3. ユーザーがいいねしたレコードを絞り込み
    .order(created_at: :desc) # 4. 投稿を作成日時の降順でソート
    .page(page) # 5. ページネーションのため、指定ページに表示するデータを選択
    .per(per_page) # 6. ページごとのデータ数を指定
  end
  
  # 検索方法分岐
  
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("content LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("content LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("content LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("content LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  
end
