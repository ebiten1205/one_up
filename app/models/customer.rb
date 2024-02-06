class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  
  # フォローをした、されたの関係
  
  #自分がフォローする（与フォロー）側の関係性
  has_many :follows, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :following_customers, through: :follows, source: :follower
  
  # 自分がフォローされる（被フォロー）側の関係性
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  
   # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :follower_customers, through: :followers, source: :follow

  # 一覧画面で使う
  #has_many :following_customers, through: :follows, source: :follow
  #has_many :follower_customers, through: :followers, source: :follower

         
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :rts, dependent: :destroy
  
   #　フォローしたときの処理
  def follow(customer_id)
    follows.create(follower_id: customer_id)
  end
  
  #　フォローを外すときの処理
  def unfollow(customer_id)
    follows.find_by(follower_id: customer_id).destroy
  end
  
  #フォローしていればtrueを返す
  def following?(customer)
    following_customers.include?(customer)
  end
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
         
  def name
    last_name + first_name
  end
  
  def self.search_for(content, search)
    if search == 'perfect'
      Customer.where(name: content)
    elsif search == 'forward'
      Customer.where('name LIKE ?', content + '%')
    elsif search == 'backward'
      Customer.where('name LIKE ?', '%' + content)
    else
      Customer.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  # is_deletedがfalseならtrueを返すようにしている
  # def active_for_authentication?
  #   super && (is_deleted == false)
  # end
end
