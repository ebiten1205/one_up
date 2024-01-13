class Customer < ApplicationRecord
  has_one_attached :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # フォローをした、されたの関係
  has_many :follows, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  # 一覧画面で使う
  has_many :following_customers, through: :follows, source: :follow
  has_many :follower_customers, through: :followers, source: :follower

         
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
         
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
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
